import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_model/bloc/auth_cubit/auth_cubit.dart';
import '../../view_model/utils/colors.dart';


class CustomTextFormField extends StatelessWidget {

  String? hintText;
  TextInputType? keyboardType;
  TextEditingController? controller;
  TextInputAction? textInputAction;
  IconData? prefixIcon;
  IconData? suffixIcon;
  IconData? secondSuffixIcon;
  bool obscureText;
  bool isPasswordText;
  String? initialValue;
  bool readOnly;
  AutovalidateMode? autovalidateMode;
  Color? firstColor;
  Color? secondColor;
  Color? textColor;
  Color? cursorColor;
  String? Function(String?)? validator;
  void Function()? onPressed;
  void Function(String)? onChanged;

  CustomTextFormField({
    this.hintText,
    this.keyboardType,
    this.controller,
    this.textInputAction,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.secondSuffixIcon,
    this.validator,
    this.initialValue,
    this.readOnly = false,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.firstColor = AppColors.white,
    this.secondColor = AppColors.grey,
    this.isPasswordText = false,
    this.onPressed,
    this.textColor,
    this.cursorColor,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = AuthCubit.get(context);
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
          cursorColor: cursorColor ?? AppColors.white,
          keyboardType: keyboardType,
          controller: controller,
          textInputAction: textInputAction,
          autofocus: false,
          readOnly: readOnly,
          obscureText: obscureText,
          initialValue: initialValue,
          onChanged: onChanged,
          style: TextStyle(
            color: textColor ?? AppColors.white,
          ),
          decoration: InputDecoration(
            isDense: true,
            labelText: hintText,
            floatingLabelStyle: const TextStyle(
              color: AppColors.grey,
            ),
            labelStyle: const TextStyle(
              color: AppColors.white,
            ),
            prefixIcon: Icon(
              prefixIcon,
              color: AppColors.grey,
            ),
            suffixIcon: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {},
              builder: (context, state) {
                return IconButton(
                  onPressed: isPasswordText ? () {
                      cubit.changeObsecure();
                  }: onPressed,
                  icon: isPasswordText ? Icon(
                    cubit.obscureText ? suffixIcon : secondSuffixIcon,
                    color: cubit.obscureText ? firstColor : secondColor,
                  ) : Icon(
                    suffixIcon ,
                    color: firstColor,
                  ),
                );
              },
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.grey,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.grey,
                width: 2,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.white,
              ),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.white,
                width: 2,
              ),
            ),
          ),
          autovalidateMode: autovalidateMode,
          validator: validator,
        ),
      ),
    );
  }
}
