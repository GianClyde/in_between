import 'package:in_between/features/home/domain/entity/game.dart';

class GameHistory {
  final String gameHistoryId;
  final String userId;
  final List<Game> gameList;

  GameHistory({
    required this.gameHistoryId,
    required this.userId,
    required this.gameList,
  });
}
