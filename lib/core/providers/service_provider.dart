import 'package:alarm_play/core/services/alarm_scheduler_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final alarmSchedulerProvider = Provider<AlarmSchedulerService>((ref) {
  final plugin = FlutterLocalNotificationsPlugin();
  return AlarmSchedulerService(plugin);
});

final flutterNotificationsProvider =
    Provider<FlutterLocalNotificationsPlugin>((ref) {
  return FlutterLocalNotificationsPlugin();
});
