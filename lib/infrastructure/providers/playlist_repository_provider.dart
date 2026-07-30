import 'package:alarm_play/infrastructure/db/isar_service.dart';
import 'package:alarm_play/data/repositories/playlist_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// este provider nos provee el playlistrepository.
final playlistRepositoryProvider = Provider((ref) {
  final isar = IsarService.instance;
  return PlaylistRepository(isar: isar);
});
