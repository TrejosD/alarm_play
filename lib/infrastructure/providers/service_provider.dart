import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/services.dart';

final alarmSchedulerProvider = Provider<AlarmSchedulerService>((ref) {
  return AlarmSchedulerService();
});

final flutterNotificationsProvider =
    Provider<FlutterLocalNotificationsPlugin>((ref) {
  return FlutterLocalNotificationsPlugin();
});

final vibrationServiceProvider = Provider<VibrationService>((ref) {
  return VibrationService();
});
