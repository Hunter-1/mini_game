
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:mini_game/space_fighter.dart';

import 'bullet.dart';
import 'knows_game_size.dart';

class Enemy extends SpriteComponent with KnowsGameSize,Hitbox,Collidable,HasGameRef<SpaceFighter>{
  Vector2 getRandomVector() {
    return (Vector2.random() - Vector2.random()) * 250;
  }
  double speed = 250;
  Enemy({
    Sprite? sprite,
    Vector2? position,
    Vector2? size,
  }) : super(sprite: sprite, position: position, size: size);
  @override
  void update(double dt){
    super.update(dt);

    this.position += Vector2(0, 1) * speed * dt;

    if (this.position.y > this.gameSize.y) {
      remove();
    }
  }
  @override
  void onMount() {
    super.onMount();
    final shape = HitboxCircle(definition: 0.9);
    addShape(shape);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    if(other is Bullet){
      this.remove();

      gameRef.player.score++;

      final particleComponent = ParticleComponent(
          particle: Particle.generate(
              count: 20,
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
  }
}

