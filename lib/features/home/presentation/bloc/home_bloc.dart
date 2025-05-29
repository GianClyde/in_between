import 'package:bloc/bloc.dart';
import 'package:in_between/core/domain/user_entity.dart';
import 'package:in_between/features/home/domain/usecase/get_user_wallet_usecase.dart';
import 'package:in_between/features/home/domain/usecase/insert_player_to_room_usecase.dart';
import 'package:in_between/features/home/domain/usecase/remove_player_from_room_usecase.dart';
import 'package:in_between/features/registration/domain/entity/wallet_entity.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUserWalletUsecase getUserWalletUsecase;
  final InsertPlayerToRoomUsecase insertPlayerToRoomUsecase;
  final RemovePlayerFromRoomUsecase removePlayerFromRoomUsecase;
  HomeBloc({
    required this.getUserWalletUsecase,
    required this.removePlayerFromRoomUsecase,
    required this.insertPlayerToRoomUsecase,
  }) : super(HomeInitial()) {
    on<HomeFetchUserWallet>((event, emit) async {
      emit(HomeLoading());

      final response = await getUserWalletUsecase.execute(userId: event.userId);

      response.fold(
        (l) => emit(HomeUserWalletFetchedFailed(message: l.message)),
        (r) => emit(
          HomeUserWalletFetchedSuccess(userWallet: r!),
        ), //yes may null handling sa repo
      );
    });

    on<HomeJoinRoom>((event, emit) async {
      emit(HomeLoading());

      final response = await insertPlayerToRoomUsecase.execute(
        user: event.user,
        roomId: event.roomId,
      );

      response.fold(
        (l) => emit(HomeJoinRoomFailed(message: l.message)),
        (r) => emit(HomeJoinRoomSuccess(roomId: r!)),
      );
    });

    on<HomeLeaveRoom>((event, emit) async {
      emit(HomeLoading());

      final response = await removePlayerFromRoomUsecase.execute(
        user: event.user,
        roomId: event.roomId,
      );

      response.fold(
        (l) => emit(HomeLeaveRoomFailed(message: l.message)),
        (r) => emit(HomeLeaveRoomSuccess(message: r.message)),
      );
    });
  }
}
