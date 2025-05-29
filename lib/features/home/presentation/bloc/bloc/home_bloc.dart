import 'package:bloc/bloc.dart';
import 'package:in_between/features/home/domain/usecase/get_user_wallet_usecase.dart';
import 'package:in_between/features/registration/domain/entity/wallet_entity.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUserWalletUsecase getUserWalletUsecase;
  HomeBloc({required this.getUserWalletUsecase}) : super(HomeInitial()) {
    on<HomeFetchUserWallet>((event, emit) async {
      emit(HomeUserWalletFetchedLoading());

      final response = await getUserWalletUsecase.execute(userId: event.userId);

      response.fold(
        (l) => emit(HomeUserWalletFetchedFailed(message: l.message)),
        (r) => emit(
          HomeUserWalletFetchedSuccess(userWallet: r!),
        ), //yes may null handling sa repo
      );
    });
  }
}
