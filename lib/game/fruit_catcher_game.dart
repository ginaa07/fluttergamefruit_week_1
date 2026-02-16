import 'dart:math';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'package:latihanfluttergame_week1/game/components/basket.dart';
import 'package:latihanfluttergame_week1/game/components/fruit.dart';
import 'package:latihanfluttergame_week1/game/managers/audio.manager.dart';

class FruitCatcherGame extends FlameGame with PanDetector, HasCollisionDetection {
  late Basket basket;
  late TextComponent scoreText;

  final Random random = Random();
  double fruitSpawnTimer = 0;
  final double fruitSpawnInterval = 1.5;

  final ValueNotifier<int> scoreNotifier = ValueNotifier<int>(0);
  int _score = 0;

  int get score => _score;
  set score(int value) {
    _score = value;
    scoreNotifier.value = value;
    scoreText.text = 'Score: $_score';
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // Set background color
    camera.viewport = FixedResolutionViewport(resolution: Vector2(400, 800));

    //Add Basket
    basket = Basket();
    await add(basket);

    scoreText = TextComponent(
      text: 'Score: 0',
      position: Vector2(20, 40),
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 24,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    await add(scoreText);

    //Play background music
    AudioManager().playBackgroundMusic(); //update
  }

  @override
  void update(double dt) {
    super.update(dt);

    //Spawn fruits
    fruitSpawnTimer += dt;
    if (fruitSpawnTimer >= fruitSpawnInterval) {
      spawnFruit();
      fruitSpawnTimer = 0;
    }
  }

  void spawnFruit() {
    final double x = random.nextDouble() * size.x;
    final fruit = Fruit(position: Vector2(x, -50));
    add(fruit);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    basket.position.x += info.delta.global.x;

    basket.position.x = basket.position.x.clamp(
      basket.size.x / 2,
      size.x - basket.size.x / 2,
    );
  }

  void incrementScore() {
    score++;
    AudioManager().playSfx('collect.mp3');
  }

  void gameOver() {
    AudioManager().playSfx('explosion.mp3');
    pauseEngine();
  }

  @override
  void onRemove() {
    AudioManager().stopBackgroundMusic();
    super.onRemove();
  }
  
  @override
  Color backgroundColor() => const Color(0xFF87CEEB); // sky blue
}


