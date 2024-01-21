part of 'booking_cubit.dart';

@immutable
abstract class BookingState {}

class BookingInitial extends BookingState {
  initializeDateFormatting() {
    // TODO: implement initializeDateFormatting
    throw UnimplementedError();
  }
}

class UploadBookingLoadingState extends BookingState{}

class UploadBookingSuccessState extends BookingState{}

class UploadBookingErrorState extends BookingState{}

class GetBookingLoadingState extends BookingState{}

class GetBookingSuccessState extends BookingState{}

class GetBookingErrorState extends BookingState{}