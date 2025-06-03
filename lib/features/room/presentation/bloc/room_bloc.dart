import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:in_between/features/home/data/models/room_model.dart';
import 'package:in_between/features/home/domain/entity/room.dart';
import 'package:in_between/features/room/domain/usecase/get_room_updates_usecase.dart';
import 'package:in_between/features/room/domain/usecase/get_room_usecase.dart';
import 'package:meta/meta.dart';

part 'room_event.dart';
part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final GetRoomUsecase getRoomUsecase;
  final GetRoomUpdatesUsecase getRoomUpdatesUsecase;

  StreamSubscription<Room>? _roomUpdatesSubscription;

  RoomBloc({required this.getRoomUsecase, required this.getRoomUpdatesUsecase})
    : super(RoomInitial()) {
    on<RoomFetch>((event, emit) async {
      emit(RoomLoading());
      final response = await getRoomUsecase.execute(roomId: event.roomId);
      print("ROOM: ${response}");
      response.fold(
        (l) {
          print("ROOM ${l.message}");
          emit(RoomFetchingFailed(message: l.message));
        },
        (r) {
          print("ROOM ${r.toString()}");
          emit(RoomFetchingSucces(room: r!));
        },
      );
    });

    on<RoomUpdate>((event, emit) {
      _roomUpdatesSubscription?.cancel();

      _roomUpdatesSubscription = getRoomUpdatesUsecase.execute().listen((room) {
        emit(RoomUpdateSuccess(room: room));
      });
    });
  }

  @override
  Future<void> close() {
    _roomUpdatesSubscription?.cancel();
    return super.close();
  }
}
