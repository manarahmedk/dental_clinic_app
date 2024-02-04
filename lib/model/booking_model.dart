import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final DateTime bookingStart;
  final DateTime bookingEnd;
  final String serviceName;
  final int serviceDuration;
  final String? phoneNumber;
  final String? userName;

  BookingModel({
    required this.bookingStart,
    required this.bookingEnd,
    required this.serviceName,
    required this.serviceDuration,
    this.phoneNumber,
    this.userName,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      bookingStart: (json['bookingStart'] as Timestamp).toDate(),
      bookingEnd: (json['bookingEnd'] as Timestamp).toDate(),
      serviceName: json['serviceName'],
      serviceDuration: json['serviceDuration'],
      phoneNumber: json['phoneNumber'],
      userName: json['userName'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bookingStart'] = Timestamp.fromDate(bookingStart);
    data['bookingEnd'] = Timestamp.fromDate(bookingEnd);
    data['serviceName'] = serviceName;
    data['serviceDuration'] = serviceDuration;
    data['phoneNumber'] = phoneNumber;
    data['userName'] = userName;
    return data;
  }
}
