part of 'wallet_bloc.dart';

@immutable
sealed class WalletEvent {}

class CashIn extends WalletEvent {
  final String username;
  final double credit;

  CashIn(this.username, this.credit);
}

class CashOut extends WalletEvent {
  final String username;
  final double credit;

  CashOut(this.username, this.credit);
}
