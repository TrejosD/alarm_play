import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';

class JustAudioService {
  final AudioPlayer player = AudioPlayer();

  Future<void> init() async {
    final session = await AudioSession.instance;

    await session.configure(
      const AudioSessionConfiguration.music(),
    );
  }

  Future<void> playAsset(String assetPath) async {
    await player.setLoopMode(LoopMode.one);
    await player.setAsset(assetPath);
    await player.play();
  }

  Future<void> stop() async {
    await player.stop();
  }
}
