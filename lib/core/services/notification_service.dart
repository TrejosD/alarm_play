import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
}
