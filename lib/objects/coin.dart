import 'package:bonfire/bonfire.dart';
import 'package:escribo_game/player/pacman.dart';
import 'package:escribo_game/utils/globals.dart';

class Coin extends GameDecoration with Sensor {
  Coin(Vector2 position)
      : super.withSprite(
          sprite: Sprite.load('tiled/dot.png'),
          position: position,
          size: Vector2(24, 24),
        );

  @override
  void onContact(GameComponent component) {
    if (component is Pacman) {
      coinsCollected.add(this);

      score += 10;

      removeFromParent();
    }
  }
}
