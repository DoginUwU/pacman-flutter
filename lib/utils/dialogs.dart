import 'package:flutter/material.dart';

class Dialogs {
  static void showGameOver(BuildContext context, VoidCallback playAgain) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: playAgain,
                child: const Text(
                  'Jogar Novamente',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Minecraft',
                    fontSize: 20.0,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  static void showGameWin(BuildContext context, VoidCallback playAgain) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                "Parabéns, você ganhou :O",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Minecraft',
                    fontSize: 20.0),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: playAgain,
                child: const Text(
                  'Jogar Novamente',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Minecraft',
                    fontSize: 20.0,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
