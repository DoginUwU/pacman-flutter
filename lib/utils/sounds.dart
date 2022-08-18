import 'package:flutter/foundation.dart';
import 'package:flame_audio/flame_audio.dart';

class Sounds {
  static Future initialize() async {
    if (!kIsWeb) {
      FlameAudio.bgm.initialize();
      await FlameAudio.audioCache.loadAll([
        'pacman_beginning.wav',
        'munch_1.wav',
        'eat_fruit.wav',
        'eat_ghost.wav',
        'intermission.wav',
        'power_pellet.wav',
        'pacman_death.wav',
      ]);
    }
  }

  static void beginning() {
    if (kIsWeb) return;
    FlameAudio.play('pacman_beginning.wav');
  }

  static void die() {
    if (kIsWeb) return;
    FlameAudio.play('pacman_death.wav');
  }

  static void muching() {
    if (kIsWeb) return;
    FlameAudio.play('munch_1.wav');
  }

  static void eatFruit() {
    if (kIsWeb) return;
    FlameAudio.play('eat_fruit.wav');
  }

  static void eatGhost() {
    if (kIsWeb) return;
    FlameAudio.play('eat_ghost.wav');
  }

  static stopBackgroundSound() {
    if (kIsWeb) return;
    return FlameAudio.bgm.stop();
  }

  static void playBackgroundSound() async {
    if (kIsWeb) return;
    await FlameAudio.bgm.stop();
    FlameAudio.bgm.play('intermission.wav', volume: 0.5);
  }

  static void playBackgroundPelletSound() async {
    if (kIsWeb) return;
    await FlameAudio.bgm.stop();
    FlameAudio.bgm.play('power_pellet.wav', volume: 0.5);
  }

  static bool isPlayingBackgroundSound() {
    if (kIsWeb) return false;
    return FlameAudio.bgm.isPlaying;
  }

  static void dispose() {
    if (kIsWeb) return;
    FlameAudio.bgm.dispose();
  }
}
