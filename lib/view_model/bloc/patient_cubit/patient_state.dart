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

class SavePatientLoadingState extends PatientState{}

class SavePatientSuccessState extends PatientState{}

class SavePatientErrorState extends PatientState{}

class UpdatePatientLoadingState extends PatientState{}

class UpdatePatientSuccessState extends PatientState{}

class UpdatePatientErrorState extends PatientState{}

class DeletePatientLoadingState extends PatientState{}

class DeletePatientSuccessState extends PatientState{}

class DeletePatientErrorState extends PatientState{}