import 'package:bonfire/bonfire.dart';
import 'package:escribo_game/player/pacman.dart';
import 'package:escribo_game/utils/sounds.dart';

import '../utils/globals.dart';

class Fruit extends GameDecoration with Sensor {
  Fruit(Vector2 position)
      : super.withSprite(
          sprite: Sprite.load('tiled/fruit.png'),
          position: position,
          size: Vector2(24, 24),
        ) {
    aboveComponents = true;
  }

  @override
  void onContact(GameComponent component) {
    if (component is Pacman) {
      score += 40;

      didPlayerGetFruit = true;

      Sounds.eatFruit();
      Sounds.playBackgroundPelletSound();

      removeFromParent();
    }
  }
}
