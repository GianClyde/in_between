import 'dart:convert';

import 'package:in_between/features/home/domain/entity/user_game.dart';

class UserGameModel extends UserGame {
  UserGameModel({
    required super.gameId,
    required super.userId,
    required super.roomId,
    required super.earning,
    required super.dateTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'gameId': gameId,
      'userId': userId,
      'roomId': roomId,
      'earning': earning,
      'dateTime': dateTime,
    };
  }

  factory UserGameModel.fromMap(Map<String, dynamic> map) {
    return UserGameModel(
      gameId: map['gameId'] as String,
      userId: map['userId'] as String,
      roomId: map['roomId'] as String,
      earning: map['earning'] as String,
      dateTime: map['dateTime'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserGameModel.fromJson(String source) =>
      UserGameModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
