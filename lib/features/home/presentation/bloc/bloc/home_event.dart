part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class HomeFetchUserWallet extends HomeEvent {
  final String userId;

  HomeFetchUserWallet({required this.userId});
}
