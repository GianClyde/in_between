// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/input.dart';
import 'package:in_between_game/features/game/components/betting/sub_components/betting_buttons.dart';

import 'package:in_between_game/features/game/my_game.dart';

class BettingButtonsRow extends PositionComponent
    with HasGameReference<MyGame> {
  late SpriteButtonComponent allInButton;
  late SpriteButtonComponent betButton;
  late SpriteButtonComponent foldButton;

  final VoidCallback allInPressed;
  final VoidCallback betPressed;
  final VoidCallback foldPressed;
  final bool hasOverlay;

  late Vector2 btnSize;
  BettingButtonsRow({
    this.hasOverlay = false,
    required this.allInPressed,
    required this.betPressed,
    required this.foldPressed,
    super.position,
    super.size,
    super.scale,
    super.priority,
  });

  @override
  FutureOr<void> onLoad() async {
    btnSize = Vector2(game.size.x * 0.1, game.size.x * 0.05);
    await _createButtons();
    return super.onLoad();
  }

  Future<void> _createButtons() async {
    final allInNormal = await Flame.images.load(
      'buttons/all_in_btn_active.png',
    );
    allInButton = BettingButtons(
      size: btnSize,
      position: Vector2(size.x / 2 - 100, size.y),
      normal: Sprite(allInNormal),
      pressed: Sprite(allInNormal),
      onPressed:
          hasOverlay
              ? () {
                null;
              }
              : allInPressed,
    );

    final betNormal = await Flame.images.load('buttons/bet_btn_active.png');
    betButton = BettingButtons(
      size: btnSize,
      position: Vector2(size.x / 2, size.y),
      normal: Sprite(betNormal),
      pressed: Sprite(betNormal),
      onPressed:
          hasOverlay
              ? () {
                null;
              }
              : betPressed,
    );

    final foldNormal = await Flame.images.load('buttons/focus_btn_active.png');
    foldButton = BettingButtons(
      size: btnSize,
      position: Vector2(size.x / 2 + 100, size.y),
      normal: Sprite(foldNormal),
      pressed: Sprite(foldNormal),
      onPressed:
          hasOverlay
              ? () {
                null;
              }
              : foldPressed,
    );

    add(allInButton);
    add(betButton);
    add(foldButton);
  }
}
