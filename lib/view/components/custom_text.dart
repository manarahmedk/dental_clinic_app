import 'package:dental_clinic_app/view_model/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final TextAlign? textAlign;
  final String? fontFamily;
  const CustomText({required this.text, this.fontWeight,Key? key, this.fontSize, this.color=AppColors.white, this.textAlign,this.fontFamily}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight:fontWeight,
        fontSize: fontSize,
        color: color ,
        fontFamily: fontFamily,
      ),
      textAlign: textAlign,
    );
  }
}