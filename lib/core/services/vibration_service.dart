import 'package:vibration/vibration.dart';

class VibrationService {
  Future<void> start() async {
    final hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator != true) return;

    Vibration.vibrate(
      pattern: [0, 1000, 500],
      repeat: 0,
    );
  }

  Future<void> stop() async {
    Vibration.cancel();
  }
}
