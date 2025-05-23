import 'package:flame/components.dart';
import 'package:in_between_game/features/game/components/player/player.dart';
import 'package:in_between_game/features/game/my_game.dart';

class PlayerManager {
  final MyGame game;
  late double angle;
  late double textAngle;
  late List<Vector2> tableCoordinates;

  //late Vector2 textPosition;
  PlayerManager({required this.game});

  void initializePlayers() {
    _createPlayers();

    print("Active player: ${game.activePlayer.user.userName}");
    print("isTurn: ${game.activePlayer.turn}");

    game.card1Val = game.activePlayer.card1!;
    game.guessCardVal = game.activePlayer.guessCard!;
    game.card2Val = game.activePlayer.card2!;
  }

  void _createPlayers() {
    tableCoordinates = [
      Vector2(game.size.x / 2 * 0.65, game.size.x / 2 * 0.55),
      Vector2(game.size.x * 0.58, game.size.x / 2 * 0.55),
      Vector2(game.size.x * 0.715, game.size.x / 2 * 0.52),
      Vector2(game.size.x * 0.675, game.size.x / 2 * 0.28),
      Vector2(game.size.x * 0.425, game.size.x / 2 * 0.28),
      Vector2(game.size.x / 2 * 0.56, game.size.x / 2 * 0.33),
    ];
    if (game.room.userList.isEmpty) {
      print("Error: No players in userList!");
      return;
    }

    game.playerMaps = {};
    for (int i = 0; i < game.room.userList.length; i++) {
      angle = _calculatePlayerAngle(i);
      textAngle = _calculatePlayerTextAngle(i);
      // textPosition = _calculatePlayerTextPosition(i, game.size);D
      game.playerMaps['player$i'] = Player(
        position: tableCoordinates[i],
        card1: game.deckManager.drawCard(),
        card2: game.deckManager.drawCard(),
        // card1: await game.deckManager.getFourOfSpades(),
        // card2: await game.deckManager.getFourOfSpades(),
        angle: angle,
        textAngle: textAngle,
        guessCard: game.deckManager.drawCard(),
        // guessCard: await game.deckManager.getAceOfSpades(),
        user: game.room.userList[i],
        playerIndex: i,
      );

      game.playerMaps['player$i']?.user.userWallet.balance -= 100;

      game.pot += 100;
      game.potHolder.updateMoney(game.pot);
      game.add(game.playerMaps['player$i']!);
    }

    game.activePlayer = game.playerMaps["player0"]!;
    game.activePlayer.setTurn(true);
  }

  double _calculatePlayerAngle(int index) {
    if (index == 2) return 270 * (3.14159265 / 180);
    if (index == 3 || index == 4) return 180 * (3.14159265 / 180);
    if (index == 5) return 90 * (3.14159265 / 180);
    return 0;
  }

  double _calculatePlayerTextAngle(int index) {
    if (index == 2) return 90 * (3.14159265 / 180);
    if (index == 3 || index == 4) return 180 * (3.14159265 / 180);
    if (index == 5) return 270 * (3.14159265 / 180);
    return 0;
  }
}
