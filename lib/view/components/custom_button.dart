import 'package:flutter/material.dart';
import '../../view_model/utils/colors.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color? textColor;
  final void Function()? onPressed;
  final Color? backgroundColor;
  const CustomButton({required this.text,this.textColor,required this.onPressed,this.backgroundColor=AppColors.white});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 25),
      child: Container(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            minimumSize: const Size(double.infinity, 50),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
          ),
          child: CustomText(
            text: text,
            color: textColor,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
