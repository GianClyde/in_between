// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Game {
  final String gameId;
  final String userId;
  final String roomId;
  final String earning;
  final String dateTime;

  Game({
    required this.gameId,
    required this.userId,
    required this.roomId,
    required this.earning,
    required this.dateTime,
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

  factory Game.fromMap(Map<String, dynamic> map) {
    return Game(
      gameId: map['gameId'] as String,
      userId: map['userId'] as String,
      roomId: map['roomId'] as String,
      earning: map['earning'] as String,
      dateTime: map['dateTime'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Game.fromJson(String source) =>
      Game.fromMap(json.decode(source) as Map<String, dynamic>);
}
