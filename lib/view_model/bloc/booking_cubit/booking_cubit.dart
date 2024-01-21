import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:booking_calendar/booking_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../model/booking_model.dart';
import '../../data/firebase/firebase.dart';

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
  );

  List<DateTimeRange> converted = [];

  List<BookingModel> booking = [];

  CollectionReference bookings =
      FirebaseFirestore.instance.collection(FirebaseKeys.bookings);

  ///This is how can you get the reference to your data from the collection, and serialize the data with the help of the Firestore [withConverter]. This function would be in your repository.
  CollectionReference<BookingModel> getBookingStream(
      {required String serviceName}) {
    return bookings
        .doc(serviceName)
        .collection('bookings')
        .withConverter<BookingModel>(
          fromFirestore: (snapshots, _) =>
              BookingModel.fromJson(snapshots.data()!),
          toFirestore: (snapshots, _) => snapshots.toJson(),
        );
  }

  ///How you actually get the stream of data from Firestore with the help of the previous function
  // /note that this query filters are for my data structure, you need to adjust it to your solution.
  Stream<dynamic>? getBookingStreamFirebase({required DateTime end, required DateTime start}) {
    return getBookingStream(serviceName:'dental Service' )
        .where('bookingStart', isGreaterThanOrEqualTo: start)
        .where('bookingStart', isLessThanOrEqualTo: end)
        .snapshots();
}

  // Stream<dynamic>? getBookingStreamFirebase(
  //     {required DateTime end, required DateTime start}) async* {
  //   print('test');
  //   emit(GetBookingLoadingState());
  //   await getBookingStream(serviceName: 'dental Service')
  //       .where('bookingStart', isGreaterThanOrEqualTo: start)
  //       .where('bookingStart', isLessThanOrEqualTo: end)
  //       .snapshots()
  //       .listen((value) {
  //     booking.clear();
  //     for (var i in value.docs) {
  //       booking.add(i.data());
  //     }
  //     emit(GetBookingSuccessState());
  //   }, onError: (error) {
  //     print(error);
  //     emit(GetBookingErrorState());
  //     throw error;
  //   });
  // }

  ///After you fetched the data from firestore, we only need to have a list of datetimes from the bookings:
  List<DateTimeRange> convertStreamResultFirebase(
      {required dynamic streamResult}) {
    ///here you can parse the streamresult and convert to [List<DateTimeRange>]
    ///Note that this is dynamic, so you need to know what properties are available on your result, in our case the [SportBooking] has bookingStart and bookingEnd property
    for (var i = 0; i < streamResult.size; i++) {
      final item = streamResult.docs[i].data();
      converted.add(
          DateTimeRange(start: (item.bookingStart!), end: (item.bookingEnd!)));
    }
    return converted;
  }

  ///This is how you upload data to Firestore
  Future<dynamic> uploadBookingFirebase(
      {required BookingService newBooking}) async {
    emit(UploadBookingLoadingState());
    await bookings
        // .doc('your id, or autogenerate')
        // .collection('bookings')
        .doc('dental Service')
        .collection('bookings')
        .add(newBooking.toJson())
        .then((value) {
      print("Booking Added");
      emit(UploadBookingSuccessState());
    }).catchError((error) {
      print("Failed to add booking: $error");
      emit(UploadBookingErrorState());
    });
  }
}
