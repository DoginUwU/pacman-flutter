import 'dart:async' as async_dart;
import 'package:bonfire/bonfire.dart';
import 'package:escribo_game/utils/sounds.dart';
import 'package:escribo_game/utils/ghost.dart';
import 'package:escribo_game/utils/globals.dart';
import 'package:escribo_game/utils/ghost_animation_sheet.dart';
import 'package:flutter/material.dart';

class Fantasminha extends SimpleEnemy
    with ObjectCollision, AutomaticRandomMovement {
  GhostType type;
  async_dart.Timer? timer;

  Fantasminha(Vector2 position, this.type)
      : super(
          position: position,
          size: Vector2(24, 24),
          speed: 16 * 3,
          life: 1,
          animation: GhostAnimationSheet(type).simpleDirectionAnimation,
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(16, 16),
          ),
        ],
      ),
    );

    aboveComponents = true;
  }

  @override
  void render(Canvas canvas) {
    if (didPlayerGetFruit) {
      animation?.playOther("danger");
    }

    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!isVisible || timer != null || !gameStarted) {
      return;
    }

    seePlayer(
      radiusVision: 16 * 5,
      observed: (player) {
        followComponent(
          player,
          dt,
          closeComponent: (comp) {
            if (comp is Player) {
              if (didPlayerGetFruit) {
                resetPosition();
              } else {
                comp.die();
              }
            }
          },
        );
      },
      notObserved: () {
        runRandomMovement(
          dt,
          speed: 16 * 6,
          maxDistance: (16 * 200).toInt(),
          timeKeepStopped: 0,
        );
      },
    );
  }

  void resetPosition() async {
    if (!isVisible || timer != null) return;
    position = await getInitialGhostPosition(type);

    isVisible = false;

    timer = async_dart.Timer(const Duration(seconds: 3), () async {
      isVisible = true;

      timer?.cancel();

      timer = null;
    });

    Sounds.eatGhost();

    score += 200;
  }
}
