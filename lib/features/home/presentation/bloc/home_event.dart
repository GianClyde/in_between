part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class HomeFetchUserWallet extends HomeEvent {
  final String userId;

  HomeFetchUserWallet({required this.userId});
}

final class HomeJoinRoom extends HomeEvent {
  final UserEntity user;
  final String roomId;

  HomeJoinRoom({required this.user, required this.roomId});
}

final class HomeLeaveRoom extends HomeEvent {
  final UserEntity user;
  final String roomId;

  HomeLeaveRoom({required this.user, required this.roomId});
}
