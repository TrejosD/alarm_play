import 'package:alarm_play/features/playlists/services/track_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final trackStorageServiceProvider = Provider<TrackStorageFileService>((ref) {
  return TrackStorageFileService();
});
