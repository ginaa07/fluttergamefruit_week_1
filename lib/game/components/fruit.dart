import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'package:latihanfluttergame_week1/game/fruit_catcher_game.dart';
import 'basket.dart';

  enum FruitType { apple, banana, orange, strawberry }

  class Fruit extends PositionComponent 
    with HasGameRef<FruitCatcherGame>, CollisionCallbacks {
      final FruitType type;
      final double fallSpeed = 200;
      