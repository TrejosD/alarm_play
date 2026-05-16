import 'package:alarm_play/core/services/vibration_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final vibrationProvider = Provider<VibrationService>((ref) {
  return VibrationService();
});
