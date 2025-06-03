import 'package:bloc/bloc.dart';
import 'package:in_between/core/domain/user_entity.dart';
import 'package:in_between/features/wallet/domain/usecase/deposit_wallet_usecase.dart';
import 'package:in_between/features/wallet/domain/usecase/update_credit_usecase.dart';
import 'package:in_between/features/wallet/domain/usecase/withdraw_wallet_usecase.dart';
import 'package:meta/meta.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final DepositWalletUsecase depositWalletUsecase;
  final UpdateCreditUsecase updateCreditUsecase;
  final WithdrawWalletUsecase withdrawWalletUsecase;
  WalletBloc({
    required this.updateCreditUsecase,
    required this.depositWalletUsecase,
    required this.withdrawWalletUsecase,
  }) : super(WalletInitial()) {
    on<CashIn>((event, emit) async {
      final updatedCredit = event.user.copyWith(
        credits: event.user.credits + event.inputedCredit,
      );
      updateCreditUsecase.execute(updatedCredit);

      emit(CashInSuccess(updatedCredit));
    });

    on<CashOut>((event, emit) async {
      emit(CashOutSuccess());
    });

    on<IncompleteField>((event, emit) async {
      emit(CashInFail());
    });

    on<DepositWallet>((event, emit) async {
      emit(WalletLoading());

      final response = await depositWalletUsecase.execute(
        userWalletId: event.userWalletId,
        depositAmount: event.depositAmount,
      );

      response.fold(
        (l) => emit(WalletDepositFailed(message: l.message)),
        (r) => emit(WalletDepositSuccess(newBalance: r)),
      );
    });

    on<WithdrawWallet>((event, emit) async {
      emit(WalletLoading());

      final response = await withdrawWalletUsecase.execute(
        userWalletId: event.userWalletId,
        withdrawAmount: event.withdrawAmount,
      );

      response.fold(
        (l) => emit(WalletWithdrawFailed(message: l.message)),
        (r) => emit(WalletWithdrawSuccess(newBalance: r)),
      );
    });
  }

  //dito mag add and minus then call updateCredit from the repo
}


// final updatedUser = event.user.copyWith(
//   credits: event.user.credits + event.inputedCredit,
// );