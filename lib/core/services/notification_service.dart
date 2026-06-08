import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin plugin;

  NotificationService(this.plugin);

  Future<void> init({
    required Function(int alarmId) onAlarmTriggered,
  }) async {
    const androidSettings = AndroidInitializationSettings('app_icon');

    const settings = InitializationSettings(android: androidSettings);

    await plugin.initialize(
        settings: settings,
        onDidReceiveNotificationResponse: (response) {
          final payload = response.payload;
          if (payload == null) return;
          final alarmId = int.parse(payload);
          onAlarmTriggered(alarmId);
        });
  }

  Future<void> checkExactAlarmPermission() async {
    if (Platform.isAndroid) {
      final androidPlugging = FlutterLocalNotificationsPlugin()
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      await androidPlugging!.requestNotificationsPermission();
      final bool? exactPermission =
          await androidPlugging.requestExactAlarmsPermission();
      print('Exact permission status: ${exactPermission}');

      final notification = await Permission.notification.status;
      if (notification.isDenied) {
        await Permission.notification.request();
      }
      var status = await Permission.scheduleExactAlarm.status;
      if (status.isDenied) {
        await Permission.scheduleExactAlarm.request();
      }
      print('Permission Exact Notification ${status.toString()}');
      print('Permission JST Notification ${notification.toString()}');
    }
  }

  Future<void> showNotification() async {}
}
