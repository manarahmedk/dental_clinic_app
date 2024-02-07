import 'package:dental_clinic_app/view/screens/show_bookings_screen.dart';
import 'package:dental_clinic_app/view_model/bloc/show_cubit/show_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_model/utils/colors.dart';
import '../../view_model/utils/navigation.dart';
import '../components/custom_button.dart';
import '../components/custom_text_form_field.dart';

class PatientLoginScreen extends StatelessWidget {
  const PatientLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = ShowCubit.get(context);
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
            key: cubit.formKey4,
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
                  const SizedBox(
                    height: 100,
                  ),
                  CustomTextFormField(
                    hintText: 'Enter Your Phone Number',
                    keyboardType: TextInputType.text,
                    controller: cubit.phoneController,
                    textInputAction: TextInputAction.next,
                    suffixIcon: Icons.phone,
                    isPasswordText: false,
                    validator: (value) {
                      if ((value ?? '').isEmpty) {
                        return 'Please, Enter phone number ';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  BlocConsumer<ShowCubit, ShowState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return CustomButton(
                        text: 'Login',
                        textColor: AppColors.background3,
                        backgroundColor: AppColors.background4,
                        onPressed: () {
                          if (cubit.formKey4.currentState!.validate()) {
                            cubit.formKey4.currentState!.save();
                            cubit.saveData();
                            cubit.getBookingStreamFirebase;
                            Navigation.push(
                              context,
                              const ShowBookingsScreen(),
                            );
                          }
                        },
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
