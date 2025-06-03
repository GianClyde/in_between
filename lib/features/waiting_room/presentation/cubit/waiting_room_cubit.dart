import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_between/features/waiting_room/domain/usecase/waiting_room_usecase.dart';

part 'waiting_room_state.dart';

class WaitingRoomCubit extends Cubit<WaitingRoomState> {
  final WaitingRoomUsecase usecase;
  WaitingRoomCubit(this.usecase) : super(GetPlayersInitial());

  Future<void> getPlayers() async {
    emit(GetPlayersLoading());

    try {
      final getPlayers = await usecase.getUser();

      emit(GetPlayersSuccess(getPlayers));
    } catch (e) {
      emit(GetPlayersFailed(e.toString()));
    }
  }
}
