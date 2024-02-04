import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_clinic_app/view_model/bloc/booking_cubit/booking_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/patient_model.dart';
import '../../data/firebase/firebase.dart';
import '../../data/local/shared_keys.dart';
import '../../data/local/shared_prefernce.dart';
part 'patient_state.dart';

class PatientCubit extends Cubit<PatientState> {
  PatientCubit() : super(PatientInitial());

  static PatientCubit get(context) => BlocProvider.of<PatientCubit>(context);

  List<PatientModel> patients = [];

  PatientModel? currentPatient;

  GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  GlobalKey<FormState> formKey3 = GlobalKey<FormState>();

  int currentIndex = 0;

  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var phoneNumberController = TextEditingController();

  var editNameController = TextEditingController();
  var editAgeController = TextEditingController();
  var editPhoneNumberController = TextEditingController();


  void changeIndex(int index) {
    currentIndex = index;
    setDataFromFirebaseToControllers();
  }


  void clearAllData() {
    nameController.clear();
    ageController.clear();
    phoneNumberController.clear();
    emit(ClearAllDataState());
  }

  Future<void> addPatientFireStore() async {
    emit(AddNewPatientLoadingState());
    PatientModel patient = PatientModel(
      name: nameController.text,
      age: ageController.text,
      phoneNumber: phoneNumberController.text,
    );
    await FirebaseFirestore.instance
        .collection(FirebaseKeys.patients)
        .add(patient.toJson())
        .then((value) {
      print(value);
      emit(AddNewPatientSuccessState());
      //getAllPatientsFromFireStore();
    }).catchError((error) {
      print(error);
      emit(AddNewPatientErrorState());
      throw error;
    });
  }

  Future<void> getAllPatientsFromFireStore() async {
    emit(GetAllPatientsLoadingState());
    FirebaseFirestore.instance
        .collection(FirebaseKeys.patients)
        .snapshots()
        .listen((value) {
      patients.clear();
      for (var i in value.docs) {
        patients.add(PatientModel.fromJson(i.data(), id: i.reference));
      }
      emit(GetAllPatientsSuccessState());
    }, onError: (error) {
      print(error);
      emit(GetAllPatientsErrorState());
      throw error;
    });
  }

  Future<void> searchPatientFromFireStore(String data) async {
    emit(GetPatientLoadingState());
    await  FirebaseFirestore.instance
        .collection(FirebaseKeys.patients)
    .where('name',isGreaterThanOrEqualTo: data)
    .where('name',isLessThan: data+'z')
    .snapshots().listen((value) {
      patients.clear();
      for (var i in value.docs) {
        patients.add(PatientModel.fromJson(i.data(), id: i.reference));
      }
      setDataFromFirebaseToControllers();
      emit(GetPatientSuccessState());
    },onError: (error) {
      print(error);
      emit(GetPatientErrorState());
      throw error;
    });
  }

  Future<void> getPatientDataFromFireStore() async {
    emit(GetPatientLoadingState());
    await patients[currentIndex].id?.get().then((value) {
      currentPatient = PatientModel.fromJson(value.data() as Map<String, dynamic>,
          id: value.reference);
      setDataFromFirebaseToControllers();
      emit(GetPatientSuccessState());
    },onError: (error) {
      print(error);
      emit(GetPatientErrorState());
      throw error;
    });
  }

  Future<void> savePatientDataFromFireStore() async {
    emit(SavePatientLoadingState());
    await patients[currentIndex].id?.get().then((value) {
      currentPatient = PatientModel.fromJson(value.data() as Map<String, dynamic>,
          id: value.reference);
      saveData();
      emit(SavePatientSuccessState());
    },onError: (error) {
      print(error);
      emit(SavePatientErrorState());
      throw error;
    });
  }

  void setDataFromFirebaseToControllers() {
    editNameController.text = currentPatient?.name! ?? "";
    editAgeController.text = currentPatient?.age! ?? "";
    editPhoneNumberController.text = currentPatient?.phoneNumber! ?? "";
  }

  void setDataFromControllersToFireStore() {
    currentPatient?.name = editNameController.text;
    currentPatient?.age = editAgeController.text;
    currentPatient?.phoneNumber = editPhoneNumberController.text;
  }

  void saveData() {
    LocalData.set(key: SharedKeys.name, value: currentPatient?.name! ?? "");
    LocalData.set(key: SharedKeys.phoneNumber, value: currentPatient?.phoneNumber! ?? "");
  }

  Future<void> updatePatient() async {
    emit(UpdatePatientLoadingState());
    setDataFromControllersToFireStore();
    await currentPatient?.id?.update(currentPatient?.toJson() ?? {}).then((value) {
      getAllPatientsFromFireStore();
      emit(UpdatePatientSuccessState());
    }).catchError((error) {
      print(error);
      emit(UpdatePatientErrorState());
      throw error;
    });
  }

  Future<void> deletePatient() async {
    emit(DeletePatientLoadingState());
    await currentPatient?.id?.delete().then((value) {
      getAllPatientsFromFireStore();
      emit(DeletePatientSuccessState());
    }).catchError((error) {
      print(error);
      emit(DeletePatientErrorState());
      throw error;
    });
  }

}
