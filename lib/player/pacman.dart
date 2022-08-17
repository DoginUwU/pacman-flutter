import 'package:bonfire/bonfire.dart';

class PlayerSpriteSheet {
  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
        "player/pacman.png",
        SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static SimpleDirectionAnimation get simpleDirectionAnimation =>
      SimpleDirectionAnimation(idleRight: idleRight, runRight: idleRight);
}

class Pacman extends SimplePlayer {
  Pacman(Vector2 position)
      : super(
          position: position,
          size: Vector2(24, 24),
          animation: PlayerSpriteSheet.simpleDirectionAnimation,
        );
}
