import 'dart:math';
import 'dart:async' as async_dart;
import 'package:escribo_game/enemy/fantasminha.dart';
import 'package:escribo_game/player/pacman.dart';
import 'package:escribo_game/utils/sounds.dart';
import 'package:escribo_game/utils/coins.dart';
import 'package:escribo_game/utils/dialogs.dart';
import 'package:escribo_game/utils/globals.dart';
import 'package:escribo_game/utils/others.dart';
import 'package:escribo_game/utils/ghost_animation_sheet.dart';
import 'package:flutter/material.dart';
import 'package:bonfire/bonfire.dart';

import 'objects/fruit.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game>
    with WidgetsBindingObserver
    implements GameListener {
  bool showDialog = false;
  late GameController gameController = GameController();
  async_dart.Timer? timer;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    gameController = GameController()..addListener(this);
    gameStarted = false;
    score = 0;
    coinsCollected = [];

    Sounds.beginning();
    timer = async_dart.Timer(const Duration(seconds: 4), () {
      Sounds.playBackgroundSound();
      gameStarted = true;

      timer?.cancel();
      timer = null;
    });

    setState(() {
      showDialog = false;
    });

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    Sounds.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;
    final tileSize = max(sizeScreen.height, sizeScreen.width) / 80;

    getCoins() async {
      coins = await generateCoins(tileSize);

      setState(() {});
    }

    getCoins();

    if (coins.isNotEmpty) {
      return Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            BonfireTiledWidget(
              gameController: gameController,
              joystick: Joystick(
                keyboardConfig: KeyboardConfig(
                  keyboardDirectionalType:
                      KeyboardDirectionalType.wasdAndArrows,
                ),
              ), // required
              map: TiledWorldMap('tiled/pacman-map.json',
                  forceTileSize: Size(tileSize, tileSize),
                  objectsBuilder: {
                    'ghost_pink': (p) =>
                        Fantasminha(p.position, GhostType.pink),
                    'ghost_red': (p) => Fantasminha(p.position, GhostType.red),
                    'ghost_blue': (p) =>
                        Fantasminha(p.position, GhostType.blue),
                    'ghost_orange': (p) =>
                        Fantasminha(p.position, GhostType.orange),
                    'fruit': (p) => Fruit(p.position),
                  }),
              components: coins,
              player: Pacman(Vector2(216, 370)),
            ),
            Positioned(
              left: 30.0,
              top: 30.0,
              child: Text(
                intFixed(score, 10).toString(),
                style: const TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'Minecraft',
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Carregando..."),
        ),
      );
    }
  }

  @override
  void changeCountLiveEnemies(int count) {}

  void _showDialogGameOver() {
    setState(() {
      showDialog = true;
    });
    Dialogs.showGameOver(
      context,
      () {
        Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const Game()),
          (Route<dynamic> route) => false,
        );
      },
    );
  }

  void _showDialogGameWin() {
    setState(() {
      showDialog = true;
    });
    Dialogs.showGameWin(
      context,
      () {
        Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const Game()),
          (Route<dynamic> route) => false,
        );
      },
    );
  }

  void checkGameOver() {
    if (gameController.player != null &&
        gameController.player?.isDead == true) {
      if (showDialog) return;

      showDialog = true;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Sounds.stopBackgroundSound();
        Sounds.die();

        _showDialogGameOver();
      });
    }
  }

  void checkGameWin() {
    if (coins.isNotEmpty && coinsCollected.length == coins.length) {
      if (showDialog) return;

      showDialog = true;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showDialogGameWin();
      });
    }
  }

  @override
  void updateGame() {
    checkGameOver();
    checkGameWin();

    if (didPlayerGetFruit && timer == null) {
      timer = async_dart.Timer(const Duration(seconds: 7), () {
        didPlayerGetFruit = false;
        Sounds.playBackgroundSound();

        timer?.cancel();
        timer = null;
      });
    }
  }
}
