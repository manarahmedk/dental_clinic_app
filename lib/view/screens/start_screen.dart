import 'package:dental_clinic_app/view/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_model/bloc/auth_cubit/auth_cubit.dart';
import '../../view_model/data/local/shared_keys.dart';
import '../../view_model/data/local/shared_prefernce.dart';
import '../../view_model/utils/colors.dart';
import '../../view_model/utils/navigation.dart';
import '../components/custom_button.dart';
import '../components/custom_text.dart';
import 'package:flutter/services.dart';

import 'choose_screen.dart';


class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
          child: BlocConsumer<AuthCubit, AuthState>(
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
                    height: 270,
                  ),
                  CustomButton(
                    text: 'Get Started',
                    textColor:  AppColors.background3,
                    backgroundColor: AppColors.background4,
                    onPressed: () {
                      // if (cubit.formKey.currentState!.validate()) {
                      //   cubit.loginWithFirebase().then((value) {
                      //     Navigation.push(context, LoginScreen());
                      //     cubit.clearData();
                      //   });
                      // }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigation.push(context, (LocalData.get(key:SharedKeys.email)!= null ? const ChooseScreen():const LoginScreen()),);
                        },
                        child: const CustomText(
                          text: 'Admin Login',
                          fontSize: 17,
                          color: AppColors.background4,
                        ),
                      ),
                    ],
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
