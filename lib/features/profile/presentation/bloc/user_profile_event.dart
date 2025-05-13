part of 'user_profile_bloc.dart';

@immutable
sealed class UserProfileEvent {}

class GetUserData extends UserProfileEvent {
  final String username;
  final String password;
  GetUserData(this.username, this.password);
}

//might add updated info
