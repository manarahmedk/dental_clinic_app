import 'dart:ffi';

import 'package:dental_clinic_app/model/patient_model.dart';
import 'package:dental_clinic_app/view/components/custom_text.dart';
import 'package:dental_clinic_app/view_model/utils/colors.dart';
import 'package:flutter/material.dart';

class PatientBuilder extends StatelessWidget {
  final PatientModel? patientModel;
  final void Function()? onTap;

  const PatientBuilder({required this.patientModel, required this.onTap,super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      //key: ValueKey(cubit.patients[index]["id"]),
      color: AppColors.background2,
      elevation: 4,
      child: ListTile(
        title: CustomText(
          text: patientModel?.name ?? '',
        ),
        onTap: onTap,
      ),
    );
  }
}
