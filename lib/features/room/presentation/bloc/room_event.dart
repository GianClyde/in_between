part of 'room_bloc.dart';

@immutable
sealed class RoomEvent {}

class RoomFetch extends RoomEvent {
  final String roomId;

  RoomFetch({required this.roomId});
}

class RoomUpdate extends RoomEvent {}
