import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin plugin;
  static const _channel = MethodChannel('alarm_play/xiaomi');

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
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    if (androidInfo.manufacturer.toLowerCase().contains('xiaomi') ||
        androidInfo.manufacturer.toLowerCase().contains('poco') ||
        androidInfo.manufacturer.toLowerCase().contains('redmi')) {
      await checkXiaomiPermissions();
      print('xiaomi permission requested');
    }
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

  Future<void> checkXiaomiPermissions() async {
    try {
      await _channel.invokeMethod('xiaomiPermissionRequest');
    } on PlatformException catch (e) {
      print("Error en el canal nativo Xiaomi: ${e.message}");
    }
  }

  Future<void> showNotification() async {}
}
