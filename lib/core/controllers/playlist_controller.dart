import 'dart:async';

import 'package:alarm_play/core/providers/playlist_repository_provider.dart';
import 'package:alarm_play/data/entities/entities.dart';
import 'package:alarm_play/data/repositories/playlist_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayListController extends AsyncNotifier<void> {
  late PlaylistRepository _repository;
  @override
  Future<void> build() async {
    _repository = ref.read(playlistRepositoryProvider);
  }

  Future<int?> createPlayList(
      {required String name, required List<PlayListTrack> tracks}) async {
    state = const AsyncLoading();
    try {
      final now = DateTime.now();
      final playList = Playlist()
        ..name = name.trim()
        ..tracks = tracks
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

  Future<bool> updatePlayList(Playlist playList) async {
    state = const AsyncLoading();
    try {
      await _repository.update(playList);
      state = AsyncData(null);
      return true;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      return false;
    }
  }

  Future<bool> deletePlayList(int playListId) async {
    state = const AsyncLoading();

    try {
      await _repository.delete(playListId);
      state = const AsyncData(null);
      return true;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      return false;
    }
  }

  Future<void> addTracks() async {}
  Future<void> removeTracks() async {}
  Future<void> reorderTracks() async {}
}
