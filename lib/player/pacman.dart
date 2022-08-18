import 'package:bonfire/bonfire.dart';
import 'package:escribo_game/utils/globals.dart';

class PlayerSpriteSheet {
  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
        "player/pacman_right.png",
        SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: 0.2,
          textureSize: Vector2(16, 16),
          loop: true,
        ),
      );

  static Future<SpriteAnimation> get runRight => SpriteAnimation.load(
        "player/pacman_right.png",
        SpriteAnimationData.sequenced(
          amount: 2,
          stepTime: 0.2,
          textureSize: Vector2(16, 16),
          loop: true,
        ),
      );

  static Future<SpriteAnimation> get idleUp => SpriteAnimation.load(
        "player/pacman_up.png",
        SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: 0.2,
          textureSize: Vector2(16, 16),
          loop: true,
        ),
      );

  static Future<SpriteAnimation> get runUp => SpriteAnimation.load(
        "player/pacman_up.png",
        SpriteAnimationData.sequenced(
          amount: 2,
          stepTime: 0.2,
          textureSize: Vector2(16, 16),
          loop: true,
        ),
      );

  static Future<SpriteAnimation> get idleDown => SpriteAnimation.load(
        "player/pacman_down.png",
        SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: 0.2,
          textureSize: Vector2(16, 16),
          loop: true,
        ),
      );

  static Future<SpriteAnimation> get runDown => SpriteAnimation.load(
        "player/pacman_down.png",
        SpriteAnimationData.sequenced(
          amount: 2,
          stepTime: 0.2,
          textureSize: Vector2(16, 16),
          loop: true,
        ),
      );

  static Future<SpriteAnimation> get getDie => SpriteAnimation.load(
        "player/pacman_die.png",
        SpriteAnimationData.sequenced(
          amount: 12,
          stepTime: 0.2,
          textureSize: Vector2(16, 16),
          loop: true,
        ),
      );

  static SimpleDirectionAnimation get simpleDirectionAnimation =>
      SimpleDirectionAnimation(
        idleRight: idleRight,
        runRight: runRight,
        runUp: runUp,
        idleUp: idleUp,
        runDown: runDown,
        idleDown: idleDown,
        enabledFlipY: true,
        enabledFlipX: true,
      );
}

class Pacman extends SimplePlayer with ObjectCollision {
  bool lockMove = false;

  Pacman(Vector2 position)
      : super(
          position: position,
          size: Vector2(24, 24),
          animation: PlayerSpriteSheet.simpleDirectionAnimation,
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(size: Vector2(16, 16)),
        ],
      ),
    );

    aboveComponents = true;
  }

  @override
  void joystickChangeDirectional(JoystickDirectionalEvent event) {
    if (isDead || lockMove || !gameStarted) return;
    super.joystickChangeDirectional(event);
  }

  @override
  void die() {
    lockMove = true;
    speed = 0;

    animation?.playOnce(
      PlayerSpriteSheet.getDie,
      onFinish: () {
        removeFromParent();
      },
    );

    super.die();
  }
}
