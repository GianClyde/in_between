part of 'user_profile_bloc.dart';

@immutable
sealed class UserProfileState {}

final class UserProfileInitial extends UserProfileState {}

final class UserDataLoaded extends UserProfileState {
  final List<UserModel> userData;
  UserDataLoaded(this.userData);
}

final class UserLoadingFailed extends UserProfileState {}
