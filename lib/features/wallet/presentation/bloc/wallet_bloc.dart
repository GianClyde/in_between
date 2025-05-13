import 'package:bloc/bloc.dart';
import 'package:in_between/core/model/user_model.dart';
import 'package:in_between/features/wallet/domain/wallet_repo.dart';
import 'package:meta/meta.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletRepo walletRepo;
  WalletBloc(this.walletRepo) : super(WalletInitial()) {
    on<CashIn>((event, emit) async {
      //retrieve current credit then add the new credit
      final currentCredit = walletRepo.getCurrentCredit(event.username);
      final updatedCredit = currentCredit + event.credit;
      await walletRepo.updateCredit(event.username, updatedCredit);
      emit(CashInSuccess());
    });

    on<CashOut>((event, emit) async {
      final currentCredit = walletRepo.getCurrentCredit(event.username);
      final updatedCredit = currentCredit - event.credit;
      await walletRepo.updateCredit(event.username, updatedCredit);
      emit(CashOutSuccess());
    });
  }

  //dito mag add and minus then call updateCredit from the repo
}
