part of 'registration_bloc.dart';

@immutable
sealed class RegistrationEvent {}

class AddUser extends RegistrationEvent {
  final UserEntity user;
  AddUser(this.user);
}

class IncompleteField extends RegistrationEvent {}
