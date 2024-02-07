import 'package:dental_clinic_app/view/screens/patient_login_screen.dart';
import 'package:dental_clinic_app/view/screens/show_bookings_screen.dart';
import 'package:dental_clinic_app/view_model/bloc/show_cubit/show_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_model/utils/colors.dart';
import '../../view_model/utils/navigation.dart';
import '../components/custom_button.dart';
import '../components/custom_text.dart';
import 'package:flutter/services.dart';



class OptionsScreen extends StatelessWidget {
  const OptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = ShowCubit.get(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.background2,
              AppColors.background,
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            stops: [0.3, 0.7],
            tileMode: TileMode.repeated,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: BlocConsumer<ShowCubit, ShowState>(
            listener: (context, state) {},
            builder: (context, state) {
              return ListView(
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  Image.asset(
                    'assets/images/dental.png',
                    height: 130,
                    width: 70,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: CustomText(
                          text: ' Al-Basma \n'
                              '     Dentist',
                          fontSize: 40,
                          fontFamily: 'Josefin Sans',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    //height: 160,
                    height: 170,
                  ),
                  CustomButton(
                    text: ' See All Bookings ',
                    textColor:  AppColors.background3,
                    backgroundColor: AppColors.background4,
                    onPressed: () {
                      cubit.showAll=true;
                      cubit.getBookingStreamFirebase;
                      Navigation.push(context, const ShowBookingsScreen());
                    },
                  ),
                  CustomButton(
                    text: ' See Your Appointment ',
                    textColor:  AppColors.background3,
                    backgroundColor: AppColors.background4,
                    onPressed: () {
                      cubit.showAll=false;
                      cubit.getBookingStreamFirebase;
                      Navigation.push(context, const PatientLoginScreen());
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
