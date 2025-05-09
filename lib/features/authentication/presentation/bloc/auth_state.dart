part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class UserLoaded extends AuthState {
  final List<UserModel> users;
  UserLoaded(this.users);
}

class UserValid extends AuthState {}

class UserInvalid extends AuthState {}
