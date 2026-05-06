import 'package:just_audio/just_audio.dart';

class AudioService {
  final player = AudioPlayer();

  Future<void> play(String sound) async {
    await player.setAsset(sound);
    await player.play();
  }

  Future<void> stop() async {
    await player.stop();
  }
}
