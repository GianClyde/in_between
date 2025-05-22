part of 'registration_bloc.dart';

@immutable
sealed class RegistrationEvent {}

// class LoadUsers extends RegistrationEvent {}

class AddUser extends RegistrationEvent {
  final UserModel user;
  AddUser(this.user);
}

class IncompleteField extends RegistrationEvent{}

