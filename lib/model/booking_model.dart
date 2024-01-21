import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  DateTime? bookingStart;
  DateTime? bookingEnd;
  String? serviceName;
  int? serviceDuration;
  String? phoneNumber;

  BookingModel({
    this.bookingStart,
    this.bookingEnd,
    this.serviceName,
    this.serviceDuration,
    this.phoneNumber,
  });

  BookingModel.fromJson(Map<String, dynamic> json) {
    bookingStart=json['bookingStart'];
    bookingEnd=json['bookingEnd'];
    serviceName=json['serviceName'];
    serviceDuration=json['serviceDuration'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bookingStart'] = bookingStart;
    data['bookingEnd'] = bookingEnd;
    data['serviceName'] = serviceName;
    data['serviceDuration'] = serviceDuration;
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}
