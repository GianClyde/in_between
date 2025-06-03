import 'package:bloc/bloc.dart';
import 'package:in_between/features/home/domain/entity/room.dart';
import 'package:in_between/features/room/domain/usecase/get_room_usecase.dart';
import 'package:meta/meta.dart';

part 'room_event.dart';
part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final GetRoomUsecase getRoomUsecase;
  RoomBloc(this.getRoomUsecase) : super(RoomInitial()) {
    on<RoomFetch>((event, emit) async {
      emit(RoomLoading());

      final response = await getRoomUsecase.execute(roomId: event.roomId);

      response.fold(
        (l) => emit(RoomFetchingFailed(message: l.message)),
        (r) => emit(RoomFetchingSucces(room: r!)),
      );
    });
  }
}
