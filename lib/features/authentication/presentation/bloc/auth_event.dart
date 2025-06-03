part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginRequest extends AuthEvent {
  final String username;
  final String password;
  LoginRequest(this.username, this.password);
}
