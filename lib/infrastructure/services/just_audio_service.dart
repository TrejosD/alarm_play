import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';

// este servicio inicia el audio player
class JustAudioService {
  final AudioPlayer player = AudioPlayer();

  Future<void> init() async {
    final session = await AudioSession.instance;

    await session.configure(
      const AudioSessionConfiguration.music(),
    );
  }

  Future<void> stop() async {
    await player.stop();
  }
}
