part of 'show_cubit.dart';

@immutable
abstract class ShowState {}

class ShowInitial extends ShowState {
  initializeDateFormatting() {
    // TODO: implement initializeDateFormatting
    throw UnimplementedError();
  }
}

class UploadBookingLoadingState extends ShowState{}

class UploadBookingSuccessState extends ShowState{}

class UploadBookingErrorState extends ShowState{}

class GetBookingLoadingState extends ShowState{}

class GetBookingSuccessState extends ShowState{}

class GetBookingErrorState extends ShowState{}