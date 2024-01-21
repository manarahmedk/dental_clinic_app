import 'package:cloud_firestore/cloud_firestore.dart';

class PatientModel {
  DocumentReference? id;
  String? name;
  String? age;
  String? phoneNumber;

  PatientModel({
    this.id,
    this.name,
    this.age,
    this.phoneNumber,
  });

  PatientModel.fromJson(Map<String, dynamic> json ,{required this.id}) {
    name = json['name'];
    age = json['age'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['age'] = age;
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}
