import 'package:bonfire/bonfire.dart';

enum GhostType {
  red,
  pink,
  blue,
  orange,
}

class GhostAnimationSheet {
  GhostType type;

  GhostAnimationSheet(this.type);

  Future<SpriteAnimation> get runRight => SpriteAnimation.load(
        'enemy/${type.name}_ghost_right.png',
        SpriteAnimationData.sequenced(
          amount: 2,
          stepTime: 0.4,
          textureSize: Vector2(16, 16),
          loop: true,
        ),
      );

  static Future<SpriteAnimation> get danger => SpriteAnimation.load(
        'enemy/ghost_danger.png',
        SpriteAnimationData.sequenced(
          amount: 2,
          stepTime: 0.2,
          textureSize: Vector2(16, 16),
          loop: true,
        ),
      );

  static Future<SpriteAnimation> get getDie => SpriteAnimation.load(
        'player/pacman_die.png',
        SpriteAnimationData.sequenced(
          amount: 12,
          stepTime: 0.2,
          textureSize: Vector2(16, 16),
          loop: true,
        ),
      );

  SimpleDirectionAnimation get simpleDirectionAnimation =>
      SimpleDirectionAnimation(
          idleRight: runRight,
          runRight: runRight,
          others: {
            "danger": danger,
          });
}
