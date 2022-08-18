import 'dart:convert';

import 'package:bonfire/bonfire.dart';
import 'package:escribo_game/objects/coin.dart';
import 'package:flutter/services.dart';

Future<List<GameComponent>> generateCoins(double tileSize) async {
  final String response =
      await rootBundle.loadString("assets/images/tiled/pacman-map.json");
  List<GameComponent> coins = [];

  final jsonFile = await json.decode(response);
  final data = jsonFile["layers"][1]["data"];
  final width = jsonFile["layers"][1]["width"];
  final height = jsonFile["layers"][1]["height"];

  for (var x = 0; x < width; x++) {
    for (var y = 0; y < height; y++) {
      final index = y * width + x;

      if (data[index] == 7) {
        coins.add(Coin(Vector2(x * tileSize, y * tileSize)));
      }
    }
  }

  return coins;
}
