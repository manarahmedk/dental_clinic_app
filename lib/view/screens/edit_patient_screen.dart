import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_model/bloc/patient_cubit/patient_cubit.dart';
import '../../view_model/utils/colors.dart';
import '../../view_model/utils/functions.dart';
import '../components/custom_button.dart';
import '../components/custom_text_form_field.dart';


class EditPatientScreen extends StatelessWidget {

  const EditPatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = PatientCubit.get(context);
    return Container(
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
        body: SingleChildScrollView(
          child: Form(
            key: cubit.formKey3,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Image.asset(
                    'assets/images/dental.png',
                    height: 230,
                    width: 170,
                  ),
                  CustomTextFormField(
                    hintText: 'Name',
                    keyboardType: TextInputType.text,
                    controller: cubit.editNameController,
                    suffixIcon: Icons.title,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if ((value ?? '').isEmpty) {
                        return 'Please, Enter patient name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    hintText: 'Age',
                    keyboardType: TextInputType.text,
                    controller: cubit.editAgeController,
                    textInputAction: TextInputAction.next,
                    suffixIcon: Icons.person,
                    validator: (value) {
                      if ((value ?? '').isEmpty) {
                        return 'Please, Enter patient age';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    hintText: 'Phone Number',
                    keyboardType: TextInputType.text,
                    controller: cubit.editPhoneNumberController,
                    textInputAction: TextInputAction.next,
                    suffixIcon: Icons.phone,
                    isPasswordText: false,
                    validator: (value) {
                      if ((value ?? '').isEmpty) {
                        return 'Please, Enter phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  BlocConsumer<PatientCubit, PatientState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return Column(
                        children: [
                          CustomButton(
                            text: 'Update Patient',
                            textColor: AppColors.background3,
                            backgroundColor: AppColors.background4,
                            onPressed: () {
                              if (cubit.formKey3.currentState!.validate()) {
                                cubit.formKey3.currentState!.save();
                                cubit.updatePatient().then((value) {
                                  Navigator.pop(context);
                                  Functions.showToast(
                                      message: "Updated Successfully");
                                });
                              }
                            },
                          ),
                          CustomButton(
                            text: 'Delete Patient',
                            textColor: AppColors.background3,
                            backgroundColor: AppColors.background4,
                            onPressed: () {
                              if (cubit.formKey3.currentState!.validate()) {
                                cubit.formKey3.currentState!.save();
                                cubit.deletePatient().then((value) {
                                  Navigator.pop(context);
                                  Functions.showToast(
                                      message: "Deleted Successfully");
                                });
                              }
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
