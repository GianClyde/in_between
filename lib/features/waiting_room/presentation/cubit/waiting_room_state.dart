part of 'waiting_room_cubit.dart';

sealed class WaitingRoomState {}

class GetPlayersInitial extends WaitingRoomState {}

class GetPlayersLoading extends WaitingRoomState {}

class GetPlayersSuccess extends WaitingRoomState {
  final List<String> players;
  GetPlayersSuccess(this.players);
}

class GetPlayersFailed extends WaitingRoomState {
  final String error;
  GetPlayersFailed(this.error);
}
