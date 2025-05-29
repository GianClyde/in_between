import 'dart:convert';

import 'package:in_between/features/home/data/models/game_model.dart';

import 'package:in_between/features/home/domain/entity/game_history.dart';

class GameHistoryModel extends GameHistory {
  GameHistoryModel({
    required super.gameHistoryId,
    required super.userId,
    required super.gameList,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'gameHistoryId': gameHistoryId,
      'userId': userId,
      'gameList': gameList.map((x) => x.toMap()).toList(),
    };
  }

  factory GameHistoryModel.fromMap(Map<String, dynamic> map) {
    return GameHistoryModel(
      gameHistoryId: map['gameHistoryId'] as String,
      userId: map['userId'] as String,
      gameList: List<GameModel>.from(
        (map['gameList'] as List<int>).map<GameModel>(
          (x) => GameModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory GameHistoryModel.fromJson(String source) =>
      GameHistoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
