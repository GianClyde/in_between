part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class GetUser extends AuthEvent {
  final String username;
  final String password;
  GetUser(this.username, this.password);
}

class IsValid extends AuthEvent {
  final String username;
  final String password;
  IsValid(this.username, this.password);
}

class LoginRequest extends AuthEvent {
  final String username;
  final String password;
  LoginRequest(this.username, this.password);
}
