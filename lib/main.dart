import 'package:dental_clinic_app/view/screens/start_screen.dart';
import 'package:dental_clinic_app/view_model/bloc/auth_cubit/auth_cubit.dart';
import 'package:dental_clinic_app/view_model/bloc/booking_cubit/booking_cubit.dart';
import 'package:dental_clinic_app/view_model/bloc/observer.dart';
import 'package:dental_clinic_app/view_model/bloc/patient_cubit/patient_cubit.dart';
import 'package:dental_clinic_app/view_model/data/local/shared_prefernce.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booking_calendar/booking_calendar.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'firebase_options.dart';
import 'view/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer=MyBlocObserver();
  await LocalData.init();
  //LocalData.clearData();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>AuthCubit(),),
        BlocProvider(create: (context)=>PatientCubit(),),
        BlocProvider(create: (context)=>BookingCubit(),),
      ],
      child: const MaterialApp(
        title: 'denatal_clinic_app',
        debugShowCheckedModeBanner: false,
        home: StartScreen(),
      ),
    );
  }
}