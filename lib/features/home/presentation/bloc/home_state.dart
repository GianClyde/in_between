part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeUserWalletFetchedSuccess extends HomeState {
  final Wallet userWallet;

  HomeUserWalletFetchedSuccess({required this.userWallet});
}

final class HomeUserWalletFetchedFailed extends HomeState {
  final String message;

  HomeUserWalletFetchedFailed({required this.message});
}

//for joining room

final class HomeJoinRoomSuccess extends HomeState {
  final String roomId; // not sure if magagamit hahahahah

  HomeJoinRoomSuccess({required this.roomId});
}

final class HomeJoinRoomFailed extends HomeState {
  final String message;

  HomeJoinRoomFailed({required this.message});
}

//shared
final class HomeLoading extends HomeState {}
