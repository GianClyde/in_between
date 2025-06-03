part of 'room_bloc.dart';

@immutable
sealed class RoomState {}

final class RoomInitial extends RoomState {}

class RoomFetchingSucces extends RoomState {
  final Room room;

  RoomFetchingSucces({required this.room});
}

class RoomFetchingFailed extends RoomState {
  final String message;

  RoomFetchingFailed({required this.message});
}

class RoomLoading extends RoomState {}
