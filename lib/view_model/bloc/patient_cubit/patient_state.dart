part of 'patient_cubit.dart';

@immutable

abstract class PatientState {}

class PatientInitial extends PatientState {}

class ClearAllDataState extends PatientState {}

class AddNewPatientLoadingState extends PatientState{}

class AddNewPatientSuccessState extends PatientState{}

class AddNewPatientErrorState extends PatientState{}

class GetAllPatientsLoadingState extends PatientState{}

class GetAllPatientsSuccessState extends PatientState{}

class GetAllPatientsErrorState extends PatientState{}

class GetPatientLoadingState extends PatientState{}

class GetPatientSuccessState extends PatientState{}

class GetPatientErrorState extends PatientState{}

