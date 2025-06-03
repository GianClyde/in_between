import 'package:bloc/bloc.dart';
import 'package:in_between/core/domain/user_entity.dart';
import 'package:in_between/features/wallet/domain/usecase/update_credit_usecase.dart';
import 'package:meta/meta.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final UpdateCreditUsecase updateCreditUsecase;
  WalletBloc(this.updateCreditUsecase) : super(WalletInitial()) {
    on<CashIn>((event, emit) async {
      final updatedCredit = event.user.copyWith(
        credits: event.user.credits + event.inputedCredit,
      );
      updateCreditUsecase.execute(updatedCredit);

      emit(CashInSuccess(updatedCredit));
    });

    on<CashOut>((event, emit) async {
      final updatedCredit = event.user.copyWith(
        credits: event.user.credits - event.inputedCredit,
      );
      updateCreditUsecase.execute(updatedCredit);
      emit(CashOutSuccess(updatedCredit));
    });

    on<IncompleteField>((event, emit) async {
      emit(CashInFail());
    });
  }
}
