import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class AudioService {
  final player = AudioPlayer();
  final audioSource = AudioSource.uri(
    Uri.parse("asset:assets/audiofiles/alarm.mp3"),
    tag: MediaItem(
      id: '1',
      title: "alarm",
    ),
  );

  Future<void> startAlarm(
      {required String assetPath, required double volume}) async {
    try {
      await player.setLoopMode(LoopMode.one);
      await player.setVolume(volume);
      await player.setAudioSource(audioSource);
      // await player.setAsset(assetPath);
      await player.play();
      AudioSource.uri(Uri.parse(assetPath),
          tag: MediaItem(id: '1', title: 'alarm'));
    } on PlayerException catch (e) {
      print('Player exception: $e');
    }
  }

  // AudioSource.uri(Uri.parse('assets/audiofiles/alarm.mp3'), tag: MediaItem(id: '1', title: 'alarm', album: 'alarm album', artist: 'penelope',playable: true, artUri: Uri.parse('assets/audiofiles/alarm.mp3')));

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
