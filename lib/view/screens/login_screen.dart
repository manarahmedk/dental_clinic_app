import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_model/bloc/auth_cubit/auth_cubit.dart';
import '../../view_model/utils/colors.dart';
import '../../view_model/utils/navigation.dart';
import '../components/custom_button.dart';
import '../components/custom_text.dart';
import '../components/custom_text_form_field.dart';
import 'choose_screen.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});


  @override
  Widget build(BuildContext context) {
    var cubit = AuthCubit.get(context);
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
            stops: [0.4, 0.7],
            tileMode: TileMode.repeated,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Form(
                key: cubit.formKey,
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 75,
                    ),
                    Image.asset(
                      'assets/images/dental.png',
                      height: 130,
                      width: 70,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: ' Al-Basma \n'
                              '     Dentist',
                          fontSize: 40,
                          fontFamily: 'Josefin Sans',
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 75,
                    ),
                    const CustomText(
                      text: 'LOGIN',
                      fontSize: 24,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextFormField(
                      hintText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      controller: cubit.emailController,
                      textInputAction: TextInputAction.next,
                      suffixIcon: Icons.email,
                      isPasswordText: false,
                      validator: (value) {
                        if ((value ?? '').isEmpty) {
                          return 'Please, Enter your Email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                      hintText: 'Password',
                      keyboardType: TextInputType.text,
                      controller: cubit.passwordController,
                      suffixIcon: Icons.remove_red_eye,
                      obscureText: cubit.obscureText,
                      isPasswordText: true,
                      secondSuffixIcon: Icons.visibility_off,
                      validator: (value) {
                        if ((value ?? '').isEmpty) {
                          return 'Please, Enter your Password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      text: 'Login',
                      textColor:  AppColors.background3,
                      backgroundColor: AppColors.background4,
                      onPressed: () {
                        if (cubit.formKey.currentState!.validate()) {
                          cubit.loginWithFirebase().then((value) {
                            Navigation.pushAndRemove(context, const ChooseScreen());
                            cubit.clearData();
                          });
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
