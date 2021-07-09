import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/particles.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

import '../space_fighter.dart';
import 'enemy.dart';

class Player extends SpriteComponent
    with Hitbox, Collidable, HasGameRef<SpaceFighter> {
  Vector2 moveDirection = Vector2.zero();
  int score = 0;
  bool hit = false;
  double speed = 300;
  Random random = Random();

  Vector2 getRandomVector() {
    return (Vector2.random() - Vector2(.5, -1)) * 250;
  }

  Player({
    Sprite? sprite,
    Vector2? position,
    Vector2? size,
  }) : super(sprite: sprite, position: position, size: size);

  @override
  void update(double dt) {
    super.update(dt);
    final particleComponent = ParticleComponent(
        particle: Particle.generate(
            count: 5,
            lifespan: .1,
            generator: (i) => AcceleratedParticle(
                  acceleration: getRandomVector().toOffset(),
                  speed: getRandomVector().toOffset(),
                  position: this.position.toOffset(),
                  child: CircleParticle(
                    radius: 2,
                    lifespan: 1,
                    paint: Paint()..color = Colors.white,
                  ),
                )));
    gameRef.add(particleComponent);
  }

  @override
  void onMount() {
    super.onMount();
    final shape = HitboxCircle(definition: 0.5);
    addShape(shape);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    if (other is Enemy) {
      hit = true;
      Vibration.vibrate();
    }
  }

  void setMoveDirection(Vector2 newMoveDirection) {
    moveDirection = newMoveDirection;
  }

  void reset() {
    this.score = 0;
    hit = false;
  }
}
