import 'dart:async';
import 'dart:math';

import 'package:alarm_play/core/providers/playlist_repository_provider.dart';
import 'package:alarm_play/data/repositories/playlist_repository.dart';
import 'package:alarm_play/features/playlists/services/track_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

import '../../data/entities/entities.dart';

class AudioService {
  final Ref _ref;
  AudioService(this._ref);
  final player = AudioPlayer();
  Timer? _volumeTimer;
  final trackStoreService = TrackStorageFileService();
  PlaylistRepository get _playlistRepository =>
      _ref.read(playlistRepositoryProvider);

  Future<void> startAlarm(
      {int? playlistId,
      required PlaybackMode mode,
      required double volume,
      required double initialVolume}) async {
    try {
      _volumeTimer?.cancel();
      final playlist = await _loadPlayList(playlistId);
      final audioSource = await _buildAudioSource(playlist);
      final index = _intialSoundIndex(mode, audioSource.length);
      print('Source Index: $index');
      await player.setAudioSources(audioSource, initialIndex: index);
      await _configurePlayBackMode(mode);
      await player.setVolume(initialVolume);
      _startFadeIn(targetVolume: volume, initialVolume: initialVolume);
      await player.play();
      // Iniciar subida de volumen
    } on PlayerException catch (e) {
      print('Player exception: $e');
    }
  }

  Future<Playlist?> _loadPlayList(int? playlistId) async {
    // si el playlistId es nulo, no devolvemos una playList nula
    if (playlistId == null) {
      return null;
    }
    // buscamos la playlist de acuerdo al Id
    final playlist = await _playlistRepository.getById(playlistId);
    // si al buscar el playList es nula , no devolvemos una playList nula
    if (playlist == null) {
      return null;
    }
    // si todo es correcto retornamos la playList
    return playlist;
  }

  int _intialSoundIndex(PlaybackMode mode, int sourceLength) {
    if (mode == PlaybackMode.sequential) {
      return 0;
    } else if (mode == PlaybackMode.shuffle) {
      return Random().nextInt(sourceLength + 1);
    }
    return 0;
  }

// este metodo siempre devuelve un audioSource. SI el playlist no existe tenemos un default. tambien revisa archivos eliminados y los omite
  Future<List<AudioSource>> _buildAudioSource(Playlist? playlist) async {
    // playlist ?? sonido por defecto
    if (playlist == null || playlist.tracks.isEmpty) {
      print('playList fue null');
      return _getDefaultAudioSurce();
    }
    final children = <AudioSource>[];
    for (final track in playlist.tracks) {
      // ignorar archivos inexistentes
      if (!await trackStoreService.exists(track)) continue;
// añadimos los tracks del playList a una lista de reproduccion
      final file = await trackStoreService.getFile(track);
      children.add(AudioSource.file(file.path,
          tag: MediaItem(id: track.localPath!, title: track.title!)));
    }
    // si la playlist esta vacia usamos el default
    if (children.isEmpty) {
      print('AudioSource list isEmpty');
      return _getDefaultAudioSurce();
    }
    return children;
  }

// este metodo organiza nuestro playList entre sequencial o shuffle
  Future<void> _configurePlayBackMode(PlaybackMode mode) async {
    switch (mode) {
      case PlaybackMode.sequential:
        await player.setShuffleModeEnabled(false);
        await player.setLoopMode(LoopMode.all);
        break;
      case PlaybackMode.shuffle:
        await player.shuffle();
        await player.setShuffleModeEnabled(true);
        await player.setLoopMode(LoopMode.all);
        break;
    }
  }

// retornamos el sonido por defult como una lista, para que el controlador de audio, siempre tenga una lista de reproduccion y no diferenciar entre listas y archivos
  List<AudioSource> _getDefaultAudioSurce() {
    final defaultAudio = <AudioSource>[];
    defaultAudio.add(AudioSource.uri(
      Uri.parse("asset:assets/audiofiles/alarm.mp3"),
      tag: MediaItem(
        id: 'default_alarm',
        title: "alarm",
      ),
    ));
    return defaultAudio;
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
