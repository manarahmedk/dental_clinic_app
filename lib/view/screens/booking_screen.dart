import 'package:booking_calendar/booking_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_model/bloc/booking_cubit/booking_cubit.dart';
import '../../view_model/utils/colors.dart';
import '../../view_model/utils/functions.dart';
import '../../view_model/utils/navigation.dart';
import '../components/custom_button.dart';
import '../components/custom_text.dart';
import '../components/custom_text_form_field.dart';
import 'choose_screen.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BookingCubit.get(context);
    print('start build');
    return Container(
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
        body: Center(
          child: BookingCalendar(
            bookingService: cubit.dentalBookingService,
            convertStreamResultToDateTimeRanges: cubit
                .convertStreamResultFirebase,
            getBookingStream: cubit
                .getBookingStreamFirebase,
            uploadBooking: cubit.uploadBookingFirebase,
            //pauseSlots: generatePauseSlots(),
            //pauseSlotText: 'LUNCH',
            //hideBreakTime: false,
            loadingWidget: const Text('Fetching data...'),
            uploadingWidget: const CircularProgressIndicator(),
            locale: 'en_US',
            startingDayOfWeek: StartingDayOfWeek.sunday,
            wholeDayIsBookedWidget:
            const Text('Sorry, for this day everything is booked'),
            //disabledDates: [DateTime(2023, 1, 20)],
            //disabledDays: [6, 7],
          ),
        ),
      ),
    );
  }
}
