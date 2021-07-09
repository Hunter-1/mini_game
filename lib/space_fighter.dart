import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:mini_game/components/enemy_manager.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/bullet.dart';
import 'components/enemy.dart';
import 'components/knows_game_size.dart';
import 'components/pause_button.dart';
import 'components/player.dart';
import 'overlays/game_over.dart';
import 'overlays/pause_menu.dart';

class SpaceFighter extends BaseGame with TapDetector, HasCollidables {
  double angle = 0;
  late Player player;
  late Sprite bulletSprite;
  late EnemyManager enemyManager;
  late SharedPreferences prefs;
  late TextComponent playerScore;
  late int highScore;
  int score = 0;

  bool isAlreadyLoaded = false;

  @override
  Future<void> onLoad() async {
    if (!this.isAlreadyLoaded) {
      await images.load('player.png');
      await images.load('enemysprite.png');
      await images.load('bullet.png');
      prefs = await SharedPreferences.getInstance();
      highScore = (prefs.getInt("highScore") ?? 0);
      Sprite playersprite = new Sprite(images.fromCache('player.png'));
      Sprite enemysprite = new Sprite(images.fromCache('enemysprite.png'));
      bulletSprite = new Sprite(images.fromCache('bullet.png'));

      player = Player(
        sprite: playersprite,
        size: Vector2(64, 64),
        position: viewport.canvasSize / 2,
      );

      player.anchor = Anchor.center;
      add(player);

      enemyManager = EnemyManager(enemysprite);
      add(enemyManager);

      playerScore = TextComponent("Score: 0",
          position: Vector2(10, 10),
          config: TextConfig(
            color: Colors.white,
            fontSize: 16,
          ));

      add(playerScore);
      this.isAlreadyLoaded = true;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    accelerometerEvents.listen((AccelerometerEvent event) {
      angle = -event.x;
    });
    if (angle > 5) {
      angle = 5;
    } else if (angle < -5) {
      angle = -5;
    }
    double half = viewport.canvasSize.x / 2;
    double angleAffect = half / 5 * angle * .9;
    player.position =
        new Vector2(half + angleAffect, viewport.canvasSize.y * .95);

    playerScore.text = "Score: ${player.score}";
    if (player.hit && !this.camera.shaking) {
      score = player.score;
      if (player.score > highScore){
        highScore = score;
        prefs.setInt("highScore",score);
      }
      this.pauseEngine();
      this.overlays.remove(PauseButton.Id);
      this.overlays.add(GameOverMenu.Id);
    }
  }

  @override
  void prepare(Component c) {
    super.prepare(c);

    if (c is KnowsGameSize) {
      c.onResize(this.size);
    }
  }

  @override
  void onResize(Vector2 canvasSize) {
    super.onResize(canvasSize);
    this.components.whereType<KnowsGameSize>().forEach((component) {
      component.onResize(this.size);
    });
  }

  @override
  void onTapDown(TapDownDetails info) {
    super.onTapDown(info);
    
    if (!this.camera.shaking) {
      Bullet bullet = Bullet(
        sprite: bulletSprite,
        size: Vector2(64, 64),
        position: this.player.position.clone(),
      );
      bullet.anchor = Anchor.center;
      add(bullet);
    }
  }

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    super.lifecycleStateChange(state);
    switch (state){
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        if(!this.player.hit) {
          this.pauseEngine();
          this.overlays.remove(PauseButton.Id);
          this.overlays.add(PauseMenu.Id);
        }
        break;
    }
  }

  void reset() {
    player.reset();
    enemyManager.reset();

    components.whereType<Enemy>().forEach((enemy) {
      enemy.remove();
    });
    components.whereType<Bullet>().forEach((bullet) {
      bullet.remove();
    });
  }
}
