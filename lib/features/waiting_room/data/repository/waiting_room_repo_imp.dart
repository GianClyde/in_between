import 'package:in_between/features/waiting_room/data/datasource/waiting_room_datasource.dart';
import 'package:in_between/features/waiting_room/domain/repository/i_waiting_room_repo.dart';

class WaitingRoomRepoImp implements IWaitingRoomRepo {
  final WaitingRoomDatasource datasource;
  WaitingRoomRepoImp(this.datasource);

  @override
  Future<List<String>> getuser() async {
    final players = await datasource.getUsers();
    return players;
  }
}
