part of 'registration_bloc.dart';

@immutable
sealed class RegistrationState {}

final class RegistrationInitial extends RegistrationState {}

final class RegistrationLoaded extends RegistrationState {
  final List<String> userData;
  RegistrationLoaded({required this.userData});
}

// might use this to change screen
final class RegistrationSuccess extends RegistrationState {}

final class RegistrationFail extends RegistrationState {}

final class RegistrationIncomplete extends RegistrationState {}
