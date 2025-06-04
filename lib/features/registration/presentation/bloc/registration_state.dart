part of 'registration_bloc.dart';

@immutable
sealed class RegistrationState {}

final class RegistrationInitial extends RegistrationState {}

final class RegistrationSuccess extends RegistrationState {}

final class RegistrationFail extends RegistrationState {}

final class RegistrationIncomplete extends RegistrationState {}
