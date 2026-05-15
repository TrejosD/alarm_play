import 'package:just_audio/just_audio.dart';

class AudioService {
  final player = AudioPlayer();

  Future<void> startAlarm(
      {required String assetPath, required double volume}) async {
    await player.setLoopMode(LoopMode.one);
    await player.setVolume(volume);
    await player.setAsset(assetPath);
    await player.play();
  }

  Future<void> play(String sound) async {
    await player.setAsset(sound);
    await player.play();
  }

  Future<void> stop() async {
    await player.stop();
  }

  void dispose() {
    player.dispose();
  }
}
