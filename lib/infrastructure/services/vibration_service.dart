import 'package:vibration/vibration.dart';

// este servicio nos permite utilizar la vibracion del dispositivo
class VibrationService {
  Future<void> start() async {
    final hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator != true) return;

    Vibration.vibrate(
      pattern: [0, 150, 100, 150, 100, 150, 100, 380, 500],
      repeat: 0,
    );
  }

  Future<void> stop() async {
    Vibration.cancel();
  }
}
