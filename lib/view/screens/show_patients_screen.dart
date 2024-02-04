import 'package:dental_clinic_app/view/screens/edit_patient_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_model/bloc/patient_cubit/patient_cubit.dart';
import '../../view_model/utils/colors.dart';
import '../../view_model/utils/navigation.dart';
import '../components/custom_text.dart';
import '../components/custom_text_form_field.dart';
import '../components/patient_builder.dart';
import 'add_patient_screen.dart';


class ShowPatientsScreen extends StatelessWidget {
  const ShowPatientsScreen({super.key});


  @override
  Widget build(BuildContext context) {
    var cubit = PatientCubit.get(context);
    return BlocProvider.value(
      value: PatientCubit.get(context)..getAllPatientsFromFireStore(),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.background2,
              AppColors.background,
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            stops: [0, 1],
            tileMode: TileMode.repeated,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: AppColors.background2,
            title: const CustomText(
              text: 'show Patients',
            ),
          ),
          body: BlocConsumer<PatientCubit, PatientState>(
            listener: (context, state) {

            },
            builder: (context, state) {
              return Visibility(
                visible: state is! GetAllPatientsLoadingState,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      onChanged: (value) => cubit.searchPatientFromFireStore(value),
                      suffixIcon: Icons.search,
                      hintText: 'Search' ,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Visibility(
                        visible: cubit.patients.isNotEmpty,
                        replacement: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: 'No Patients Added !',
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                                color: AppColors.background2,
                              ),
                            ],
                          ),
                        ),
                        child: ListView.builder(
                          //controller: cubit.scrollController,
                          itemBuilder: (context, index) {
                            return PatientBuilder(
                              patientModel: cubit.patients[index],
                              onTap: () {
                                cubit.changeIndex(index);
                                cubit.getPatientDataFromFireStore().then((value) {
                                  Navigation.push(
                                    context,
                                    const EditPatientScreen(),
                                  );
                                });
                              },
                            );
                          },
                          itemCount: cubit.patients.length,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigation.push(context, const AddPatientScreen());
            },
            backgroundColor: AppColors.background3,
            child: const Icon(
              Icons.add,
            ),
          ),
        ),
      ),
    );
  }
}
