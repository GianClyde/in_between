import 'package:in_between/core/domain/user_entity.dart';

class Room {
  final String roomId;
  final List<UserEntity> userList;
  final double pot;
  Room({this.pot = 0, required this.roomId, required this.userList});
}
