import 'dart:math';

import 'package:escribo_game/objects/coin.dart';
import 'package:escribo_game/player/pacman.dart';
import 'package:flutter/material.dart';
import 'package:bonfire/bonfire.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;
    final tileSize = max(sizeScreen.height, sizeScreen.width) / 80;

    return Material(
      color: Colors.transparent,
      child: BonfireTiledWidget(
        joystick: Joystick(
          keyboardConfig: KeyboardConfig(
            keyboardDirectionalType: KeyboardDirectionalType.wasdAndArrows,
          ),
        ), // required
        map: TiledWorldMap(
          'tiled/pacman-map.json',
          forceTileSize: Size(tileSize, tileSize),
          objectsBuilder: {
            'Coins': (p) => Coin(p.position, p.size),
          },
        ),
        player: Pacman(Vector2(40, 40)),
      ),
    );
  }
}
