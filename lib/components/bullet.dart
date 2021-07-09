import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

import 'enemy.dart';

class Bullet extends SpriteComponent with Hitbox, Collidable{

  double speed = 450;

  Bullet ({
    Sprite? sprite,
    Vector2? position,
    Vector2? size,
  }) : super(sprite: sprite, position: position, size: size);

  @override
  void onMount() {
    // TODO: implement onMount
    super.onMount();
    final shape = HitboxCircle(definition: 0.5);
    addShape(shape);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);
    if(other is Enemy){
      this.remove();
    }
  }


  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);

    this.position += Vector2(0, -1) * this.speed * dt;

    if (this.position.y < 0) {
      remove();
    }
  }
}
