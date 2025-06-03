// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:in_between/core/domain/user_entity.dart';

class Room {
  final String roomId;
  final List<UserEntity> userList;
  final double pot;
  Room({this.pot = 0, required this.roomId, required this.userList});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'roomId': roomId,
      'userList': userList.map((x) => x.toMap()).toList(),
      'pot': pot,
    };
  }

  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      roomId: map['roomId'] as String,
      userList: List<UserEntity>.from(
        (map['userList'] as List<int>).map<UserEntity>(
          (x) => UserEntity.fromMap(x as Map<String, dynamic>),
        ),
      ),
      pot: map['pot'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Room.fromJson(String source) =>
      Room.fromMap(json.decode(source) as Map<String, dynamic>);
}
