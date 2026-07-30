import 'dart:async';

import 'package:alarm_play/infrastructure/providers/playlist_repository_provider.dart';
import 'package:alarm_play/data/entities/entities.dart';
import 'package:alarm_play/data/repositories/playlist_repository.dart';
import 'package:alarm_play/features/playlists/pendingEntity/pending_track.dart';
import 'package:alarm_play/features/playlists/providers/track_storage_service_provider.dart';
import 'package:alarm_play/features/playlists/services/track_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayListController extends AsyncNotifier<void> {
  late PlaylistRepository _repository;
  late TrackStorageFileService _trackStorageFileService;
  @override
  Future<void> build() async {
    _repository = ref.read(playlistRepositoryProvider);
    _trackStorageFileService = ref.read(trackStorageServiceProvider);
  }

// metodo crea una playlist, y guarda los archivos de audio en memoria local
  Future<int?> createPlayList(
      {required String name, required List<PendingTrack> tracks}) async {
    state = const AsyncLoading();
    List<PlayListTrack> copied;
    try {
      final now = DateTime.now();
      copied = await _trackStorageFileService.copyTracks(tracks);
      final playList = Playlist()
        ..name = name.trim()
        ..tracks = copied
        ..createdAt = now
        ..updatedAt = now;

      final id = await _repository.create(playList);
      state = const AsyncData(null);
      return id;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      return null;
    }
  }

// metodo edita un playlist, revisa que archivos de audio estan en memoria local, eliminando los innecesario y añadiendo nuevos.
  Future<bool> updatePlayList(
      {required Playlist original,
      required String name,
      required List<PlayListTrack> existingTracks,
      required List<PendingTrack> newTracks}) async {
    state = const AsyncLoading();
    List<PlayListTrack> copied = [];
    try {
      // los archivos nuevos se copian dentro de la carpeta desiganada
      copied = await _trackStorageFileService.copyTracks(newTracks);
      // se crea una unica y nueva lista con ambos archivos 'existentes + nuevos'
      final removed = await _updateRemovedTracks(original, existingTracks);
      // se crea una playList temporal previo a modificar en repositorio. Para evitar modificar la original antes, en caso ocurra un error al modificar la DB
      final finalTracks = _buildFinalTrackList(existingTracks, copied);
      final updatedPlaylist = Playlist()
        ..id = original.id
        ..name = original.name
        ..createdAt = original.createdAt
        ..tracks = finalTracks
        ..updatedAt = original.updatedAt;

      // se modifica el repositorio
      await _repository.update(updatedPlaylist);
      state = const AsyncData(null);
      try {
        // se remueven los archivos eliminados de la lista
        await _trackStorageFileService.deleteTracks(removed);
      } catch (e) {
        print('Some error during deleting files $e');
      }
      return true;
    } catch (e, s) {
      try {
        // si algo falla eliminamos los archivos copiados en la memoria
        await _trackStorageFileService.deleteTracks(copied);
      } catch (e) {
        print('Some error during deleting copied files $e');
      }
      state = AsyncError(e, s);
      return false;
    }
  }

// metodo crea una playlist temporal entre los archivos nuevos y los ya existentes en memoria, previo a guardar en DB. Para luego modificar la DB una sola vez, evitando errores
  List<PlayListTrack> _buildFinalTrackList(
      List<PlayListTrack> existingTracks, List<PlayListTrack> copiedTracks) {
    final tracks = [...existingTracks, ...copiedTracks];
    return tracks;
  }

// este metodo crea una lista de archivos que necesitamos eliminar de la memoria local. Si todo es correcto, se eliminan estos archivos al final. *Asi evitamos eliminar archivos desde el inicio, y un posible error nos detiene el metodo, y estos archivos ya fueron eliminados.
  Future<List<PlayListTrack>> _updateRemovedTracks(
      Playlist original, List<PlayListTrack> existingTracks) async {
    // tomamos todos los archivos de audio de la lista original
    final originalTracks = List<PlayListTrack>.from(original.tracks);
    // de la lista original, tomamos 'excluimos' los que no hacen match con la lista actual.
    final removedTracks = originalTracks.where((originalTrack) {
      return !existingTracks
          .any((track) => track.localPath == originalTrack.localPath);
    }).toList();
    return removedTracks;
  }

// metodo elimina una playList del DB junto con sus archivos en memoria local
  Future<bool> deletePlayList(int playListId) async {
    state = const AsyncLoading();
    final playlist = await _repository.getById(playListId);
    try {
      await _repository.delete(playListId);
      await _trackStorageFileService.deletePlaylistFiles(playlist!);
      state = const AsyncData(null);
      return true;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      return false;
    }
  }
}
