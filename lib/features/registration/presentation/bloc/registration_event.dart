part of 'registration_bloc.dart';

@immutable
sealed class RegistrationEvent {}

class LoadUsers extends RegistrationEvent {}

class AddUser extends RegistrationEvent {
  final UserModel user;
  AddUser(this.user);
}

// class IsFilled extends RegistrationEvent {
//   final String username;
//   final String password;
//   final String name;
//   final String mobile;
//   final String bdate;

//   IsFilled(this.username, this.password, this.name, this.mobile, this.bdate);
// }
