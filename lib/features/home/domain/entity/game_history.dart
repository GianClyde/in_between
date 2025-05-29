import 'dart:convert';

import 'package:in_between/features/home/domain/entity/user_game.dart';

class GameHistory {
  final String gameHistoryId;
  final String userId;
  final List<UserGame> gameList;

  GameHistory({
    required this.gameHistoryId,
    required this.userId,
    required this.gameList,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'gameHistoryId': gameHistoryId,
      'userId': userId,
      'gameList': gameList.map((x) => x.toMap()).toList(),
    };
  }

  factory GameHistory.fromMap(Map<String, dynamic> map) {
    return GameHistory(
      gameHistoryId: map['gameHistoryId'] as String,
      userId: map['userId'] as String,
      gameList: List<UserGame>.from(
        (map['gameList'] as List<int>).map<UserGame>(
          (x) => UserGame.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory GameHistory.fromJson(String source) =>
      GameHistory.fromMap(json.decode(source) as Map<String, dynamic>);
}
