import 'package:in_between/features/waiting_room/domain/repository/i_waiting_room_repo.dart';

class WaitingRoomUsecase {
  final IWaitingRoomRepo repo;
  WaitingRoomUsecase(this.repo);

  Future<List<String>> getUser() async {
    final players = await repo.getuser();
    return players;
  }
}
