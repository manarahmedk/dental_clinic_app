import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
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

  int currentIndex = 0;

  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var phoneNumberController = TextEditingController();

  var editNameController = TextEditingController();
  var editAgeController = TextEditingController();
  var editPhoneNumberController = TextEditingController();


  void changeIndex(int index) {
    currentIndex = index;
    //setDataFromFirebaseToControllers();
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
        .where('user_id', isEqualTo: LocalData.get(key: SharedKeys.uid))
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

  Future<void> getTaskFromFireStore() async {
    emit(GetPatientLoadingState());
    await patients[currentIndex].id?.get().then((value) {
      currentPatient = PatientModel.fromJson(value.data() as Map<String, dynamic>,
          id: value.reference);
      setDataFromFirebaseToControllers();
      emit(GetPatientSuccessState());
    }).catchError((error) {
      print(error);
      emit(GetPatientErrorState());
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

  // Future<void> updateTaskFire() async {
  //   emit(UpdateTaskLoadingState());
  //   setDataFromControllersToFireStore();
  //   await currentTask?.id?.update(currentTask?.toJson() ?? {}).then((value) {
  //     emit(UpdateTaskSuccessState());
  //     getAllTasksFromFireStore();
  //   }).catchError((error) {
  //     print(error);
  //     emit(UpdateTaskSuccessState());
  //     throw error;
  //   });
  // }

  // Future<void> deleteTaskFire() async {
  //   emit(DeleteTaskLoadingState());
  //   await currentTask?.id?.delete().then((value) {
  //     emit(DeleteTaskSuccessState());
  //     getAllTasksFromFireStore();
  //   }).catchError((error) {
  //     print(error);
  //     emit(DeleteTaskErrorState());
  //     throw error;
  //   });
  // }

}
