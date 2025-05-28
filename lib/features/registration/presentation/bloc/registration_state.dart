part of 'registration_bloc.dart';

@immutable
sealed class RegistrationState {}

final class RegistrationInitial extends RegistrationState {}

// final class RegistrationLoaded extends RegistrationState {
//   final List<String> userData;
//   RegistrationLoaded({required this.userData});
// }

// might use this to change screen
final class RegistrationSuccess extends RegistrationState {}

final class RegistrationFailed extends RegistrationState {
  final String message;

  RegistrationFailed({required this.message});
}

final class RegistrationIncomplete extends RegistrationState {}

final class RegistrationLoading extends RegistrationState {}
