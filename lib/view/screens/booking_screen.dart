import 'package:booking_calendar/booking_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_model/bloc/booking_cubit/booking_cubit.dart';
import '../../view_model/utils/colors.dart';
import '../components/custom_text.dart';
class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BookingCubit.get(context);
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
        appBar: AppBar(
          title: const CustomText(text: 'Booking',),
          backgroundColor: AppColors.background,
        ),
        body: SafeArea(
          child: BlocConsumer<BookingCubit, BookingState>(
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
                //pauseSlots: generatePauseSlots(),
                //pauseSlotText: 'LUNCH',
                //hideBreakTime: false,
                bookedSlotColor: AppColors.background2,
                availableSlotColor: AppColors.white,
                selectedSlotColor: Colors.cyan,
                loadingWidget: const Text('Fetching data...'),
                uploadingWidget: const Center(child:  CircularProgressIndicator()),
                locale: 'en_US',
                startingDayOfWeek: StartingDayOfWeek.saturday,
                wholeDayIsBookedWidget:
                const Text('Sorry, for this day everything is booked'),
                disabledDays: const [5],
              );
            },
          ),
        ),
      ),
    );
  }
}