import 'package:alarm_play/infrastructure/services/audio_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final audioServiceProvider = Provider<AudioService>((ref) {
  return AudioService(ref);
});
