import 'package:alarm_play/features/playlists/services/track_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// este provider nos provee el servicio para manejar el almacenamiento de archivos de audio
final trackStorageServiceProvider = Provider<TrackStorageFileService>((ref) {
  return TrackStorageFileService();
});
