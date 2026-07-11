import 'dart:async';

import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class AudioService {
  final player = AudioPlayer();
  Timer? _volumeTimer;

  Future<void> startAlarm(
      {required String assetPath,
      required double volume,
      required double initialVolume}) async {
    try {
      _volumeTimer?.cancel();
      final audioSource = AudioSource.uri(
        Uri.parse(assetPath),
        tag: MediaItem(
          id: '1',
          title: "alarm",
        ),
      );
      await player.setLoopMode(LoopMode.one);
      await player.setAudioSource(audioSource);
      await player.setVolume(initialVolume);
      _startFadeIn(targetVolume: volume, initialVolume: initialVolume);
      await player.play();
      // Iniciar subida de volumen
    } on PlayerException catch (e) {
      print('Player exception: $e');
    }
  }

// metodo responsable del ascendingVolume
  void _startFadeIn(
      {required double targetVolume, required double initialVolume}) {
    double currentVolume = initialVolume;
    // cuantos pasos deseamos de subida
    const stepDuration = Duration(milliseconds: 150);
    /*Calculo de incremento por pasos:
    10 segundos = 10000 ms pasos totales 10000/150 = 66.6
    incremento = targetVolume / 66.6 pasos
    */
    final double totalDurationSeconds = 5.0;
    final int totalSteps = (totalDurationSeconds.toInt() * 100);
    final double volumeIncrement = targetVolume / totalSteps;
    _volumeTimer = Timer.periodic(stepDuration, (timer) async {
      currentVolume += volumeIncrement;
      if (currentVolume >= targetVolume) {
        currentVolume = targetVolume;
        timer.cancel();
      }
      try {
        await player.setVolume(currentVolume);
      } catch (e) {
        timer.cancel();
      }
    });
  }

  // AudioSource.uri(Uri.parse('assets/audiofiles/alarm.mp3'), tag: MediaItem(id: '1', title: 'alarm', album: 'alarm album', artist: 'penelope',playable: true, artUri: Uri.parse('assets/audiofiles/alarm.mp3')));

  Future<void> play(String sound) async {
    await player.setAsset(sound);
    await player.play();
  }

  Future<void> stop() async {
    _volumeTimer?.cancel();
    await player.stop();
  }

  void dispose() {
    player.dispose();
  }
}
