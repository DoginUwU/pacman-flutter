import 'dart:convert';

import 'package:bonfire/bonfire.dart';
import 'package:escribo_game/utils/ghost_animation_sheet.dart';
import 'package:flutter/services.dart';

Future<Vector2> getInitialGhostPosition(GhostType type) async {
  final String response =
      await rootBundle.loadString("assets/images/tiled/pacman-map.json");

  final jsonFile = await json.decode(response);
  final data = jsonFile["layers"][2]["objects"];
  Vector2 ghostPosition = Vector2(0, 0);

  for (var x = 0; x < data.length; x++) {
    if (data[x]["name"] == 'ghost_${type.name}') {
      ghostPosition.x = data[x]["x"];
      ghostPosition.y = data[x]["y"];
    }
  }

  return ghostPosition;
}
