part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class GetUser extends AuthEvent {}

class IsValid extends AuthEvent {
  final String username;
  final String password;
  IsValid(this.username, this.password);
}
