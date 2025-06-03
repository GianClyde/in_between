import 'dart:convert';
import 'package:in_between/features/home/domain/entity/room.dart';
import 'package:in_between/features/registration/data/model/user_model.dart';

class RoomModel extends Room {
  RoomModel({required super.roomId, required super.userList});

  @override
  Map<String, dynamic> toMap() {
    return {
      'roomId': roomId,
      'userList': userList.map((x) => (x as UserModel).toMap()).toList(),
    };
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      roomId: map['roomId'] as String,
      userList:
          map['userlist'] !=
                  null // Changed from 'userList' to 'userlist'
              ? List<UserModel>.from(
                (map['userlist'] as List).map<UserModel>(
                  (x) => UserModel.fromMap(x as Map<String, dynamic>),
                ),
              )
              : [],
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory RoomModel.fromJson(String source) =>
      RoomModel.fromMap(json.decode(source));
}
