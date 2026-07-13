import 'package:alarm_play/core/db/isar_service.dart';
import 'package:alarm_play/data/entities/playlist_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

final playlistListProvider = StreamProvider<List<Playlist>>((ref) {
  final isar = IsarService.instance;
  return isar.playlists.where().watch(fireImmediately: true);
});
