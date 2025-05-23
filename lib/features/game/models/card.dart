import 'dart:math';
import 'package:flame/cache.dart';
import 'package:flame/components.dart';

class Card {
  final String suit;
  final String value;
  final Sprite front;
  final Sprite back;

  Card({
    required this.suit,
    required this.value,
    required this.front,
    required this.back,
  });
}
