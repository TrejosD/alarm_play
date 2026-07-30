import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../db/isar_service.dart';
import '../services/services.dart';
// este archivo es nuestro proveedor de servicios

// este provider nos provee el servicio para calendarizar uestras alarmas
final alarmSchedulerProvider = Provider<AlarmSchedulerService>((ref) {
  return AlarmSchedulerService();
});

// este provider nos provee el servicio para local notifications
final flutterNotificationsProvider =
    Provider<FlutterLocalNotificationsPlugin>((ref) {
  return FlutterLocalNotificationsPlugin();
});

// este provider nos provee el servicio de vibracion del dispositivo
final vibrationServiceProvider = Provider<VibrationService>((ref) {
  return VibrationService();
});

// este provider nos proveee el servicio de audio
final audioServiceProvider = Provider<AudioService>((ref) {
  return AudioService(ref);
});

// este provider nos provee el servicio para restaurar todas las alarmas activas
final alarmRestoreProvider = Provider<AlarmRestoreService>((ref) {
  final isar = IsarService.instance;
  final alarmScheduler = ref.read(alarmSchedulerProvider);

  return AlarmRestoreService(isar: isar, alarmScheduler: alarmScheduler);
});
