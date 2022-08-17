import 'package:bonfire/bonfire.dart';

class Coin extends GameDecoration with ObjectCollision {
  Coin(Vector2 position, Vector2 size)
      : super.withSprite(
          sprite: Sprite.load('player/pacman.png'),
          position: position,
          size: size,
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(width, height / 4),
            align: Vector2(0, height * 0.75),
          ),
        ],
      ),
    );
  }
}
