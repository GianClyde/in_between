import 'package:in_between_game/features/game/managers/game_flow_manager.dart';
import 'package:in_between_game/features/game/managers/player_manager.dart';
import 'package:in_between_game/features/game/managers/ui_manager.dart';
import 'package:in_between_game/features/game/my_game.dart';

class GameLifecycleManager {
  final MyGame game;
  final UIManager uiManager;
  final PlayerManager playerManager;
  final GameFlowManager gameFlowManager;

  GameLifecycleManager({
    required this.game,
    required this.uiManager,
    required this.playerManager,
    required this.gameFlowManager,
  });

  void startGame() async {
    playerManager.initializePlayers();
  }

  void pauseGame() {
    game.pauseEngine();
    //game.uiManager.showPauseOverlay();
  }

  void resumeGame() {
    game.resumeEngine();
    // game.uiManager.hidePauseOverlay();
  }

  void stopGame() {
    game.pauseEngine();
    game.children.clear();
    game.overlays.clear();
  }
}
