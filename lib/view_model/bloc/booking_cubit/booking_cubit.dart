import 'dart:async';
import 'dart:developer';

import 'package:booking_calendar/booking_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/booking_model.dart';
import '../../data/firebase/firebase.dart';
import '../../data/local/shared_keys.dart';
import '../../data/local/shared_prefernce.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingInitial());

  static BookingCubit get(context) => BlocProvider.of<BookingCubit>(context);

  final now = DateTime.now();

  BookingService dentalBookingService = BookingService(
    serviceName: 'dental Service',
    serviceDuration: 30,
    bookingEnd: DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 20, 0),
    bookingStart: DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 12, 0),
    userName: LocalData.get(key: SharedKeys.name),
    userPhoneNumber: LocalData.get(key: SharedKeys.phoneNumber),
  );

  List<DateTimeRange> converted = [];

  CollectionReference bookings =
      FirebaseFirestore.instance.collection(FirebaseKeys.bookings);

  ///This is how can you get the reference to your data from the collection, and serialize the data with the help of the Firestore [withConverter]. This function would be in your repository.
  CollectionReference<BookingModel> getBookingStream() {
    return bookings.withConverter<BookingModel>(
      fromFirestore: (snapshots, _) => BookingModel.fromJson(snapshots.data()!),
      toFirestore: (snapshots, _) => snapshots.toJson(),
    );
  }

  ///How you actually get the stream of data from Firestore with the help of the previous function
  ///note that this query filters are for my data structure, you need to adjust it to your solution.

  Stream<List<BookingModel>>? getBookingStreamFirebase(
      {required DateTime end, required DateTime start}) {
    log("called", name: "getBookingStreamFirebase");
    final stream = getBookingStream()
        .where('bookingStart', isGreaterThanOrEqualTo: start)
        .where('bookingStart', isLessThanOrEqualTo: end)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((e) => e.data()).toList())
      ..listen((snapshot) {
        if (snapshot.isNotEmpty) {
          log(snapshot.first.serviceName,
              name: "getBookingStreamFirebase serviceName");
        }
      });
    stream.listen((list) {
      log(list.length.toString(), name: "getBookingStreamFirebase length");
    });
    return stream;
  }

  ///After you fetched the data from firestore, we only need to have a list of datetimes from the bookings:
  List<DateTimeRange> convertStreamResultFirebase(
      {required dynamic streamResult}) {
    ///here you can parse the streamresult and convert to [List<DateTimeRange>]
    ///Note that this is dynamic, so you need to know what properties are available on your result, in our case the [SportBooking] has bookingStart and bookingEnd property
    log(streamResult.runtimeType.toString(),
        name: "convertStreamResultFirebase");
    if (streamResult is! List) return [];
    log(streamResult.length.toString(),
        name: "convertStreamResultFirebase length");
    for (var i = 0; i < streamResult.length; i++) {
      final item = streamResult[i] as BookingModel;
      converted.add(
          DateTimeRange(start: (item.bookingStart), end: (item.bookingEnd)));
    }
    return converted;
  }

  ///This is how you upload data to Firestore
  Future<dynamic> uploadBookingFirebase(
      {required BookingService newBooking}) async {
    emit(UploadBookingLoadingState());
    await bookings.add(newBooking.toModel.toJson()).then((value) {
      print("Booking Added");
      emit(UploadBookingSuccessState());
    }).catchError((error) {
      print("Failed to add booking: $error");
      emit(UploadBookingErrorState());
    });
  }
}

extension Mapper on BookingService {
  BookingModel get toModel => BookingModel(
        bookingStart: bookingStart,
        bookingEnd: bookingEnd,
        serviceName: serviceName,
        serviceDuration: serviceDuration,
        userName: userName,
        phoneNumber: userPhoneNumber,
      );
}
