import 'package:booking_calendar/booking_calendar.dart';
import 'package:dental_clinic_app/view_model/bloc/show_cubit/show_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_model/utils/colors.dart';
import '../components/custom_text.dart';

class ShowBookingsScreen extends StatelessWidget {
  const ShowBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = ShowCubit.get(context);
    return BlocProvider.value(
      value: ShowCubit.get(context)..getBookingStreamFirebase,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.background2,
              AppColors.background,
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            stops: [0, 1],
            tileMode: TileMode.repeated,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const CustomText(text: 'Bookings',),
            backgroundColor: AppColors.background,
          ),
          body: SafeArea(
            child: BlocConsumer<ShowCubit, ShowState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                return BookingCalendar(
                  key: const Key("BookingCalendar"),
                  bookingService: cubit.dentalBookingService,
                  convertStreamResultToDateTimeRanges: cubit
                      .convertStreamResultFirebase,
                  getBookingStream: cubit
                      .getBookingStreamFirebase,
                  uploadBooking: cubit.uploadBookingFirebase,
                  bookedSlotColor: AppColors.background2,
                  availableSlotColor: AppColors.white,
                  selectedSlotColor: Colors.cyan,
                  loadingWidget: const Text('Fetching data...'),
                  uploadingWidget: const Center(
                      child: CircularProgressIndicator()),
                  locale: 'en_US',
                  startingDayOfWeek: StartingDayOfWeek.saturday,
                  wholeDayIsBookedWidget:
                  const Text('Sorry, for this day everything is booked'),
                  disabledDays: const [5],
                  hideButton: true,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}