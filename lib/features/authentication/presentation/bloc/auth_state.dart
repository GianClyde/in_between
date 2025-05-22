part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class UserLoaded extends AuthState {
  final UserEntity users;
  UserLoaded(this.users);
}

class UserNotLoaded extends AuthState {}

class UserValid extends AuthState {}

class UserInvalid extends AuthState {}
