import 'dart:math';

import 'package:flame/components.dart';
import 'package:mini_game/components/enemy.dart';
import 'package:mini_game/components/knows_game_size.dart';
import 'package:mini_game/space_fighter.dart';

class EnemyManager extends BaseComponent
    with KnowsGameSize, HasGameRef<SpaceFighter> {
  late Timer timer;
  Sprite sprite;
  Random random = Random();

  EnemyManager(this.sprite) : super() {
    timer = Timer(1, callback: spawnEnemy, repeat: true);
  }

  void spawnEnemy() {
    Vector2 initialSize = Vector2(64, 64);
    Vector2 position = Vector2(random.nextDouble() * gameSize.x, 0);

    position.clamp(initialSize / 2, gameSize - initialSize / 2);

    Enemy enemy = Enemy(
      sprite: sprite,
      size: initialSize,
      position: position,
    );

    enemy.anchor = Anchor.center;

    gameRef.add(enemy);
  }

  @override
  void onMount() {
    super.onMount();
    timer.start();
  }

  @override
  void onRemove() {
    super.onRemove();
    timer.stop();
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    timer.update(dt);
  }

  void reset() {
    timer.stop();
    timer.start();
  }
}
