import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../data/entities/entities.dart';

class AlarmSchedulerService {
  final FlutterLocalNotificationsPlugin notifications;

  AlarmSchedulerService(this.notifications);

  // todo filtrar si el schedule date sera antes de hoy y sumarle un dia

  Future<void> scheduleAlarm(Alarm alarm) async {
    print('Scheduled alarm ${alarm.id}');
    print('nextTrigger ${alarm.nextTrigger}');
    if (alarm.nextTrigger == null) return;
    await notifications.zonedSchedule(
      id: alarm.id ?? 1,
      title: 'Alarm',
      body: alarm.label ?? 'Wake up',
      scheduledDate: tz.TZDateTime.from(alarm.nextTrigger!, tz.local),
      notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails('alarm_channel', 'alarms',
              importance: Importance.max,
              priority: Priority.high,
              fullScreenIntent: true,
              category: AndroidNotificationCategory.alarm,
              playSound: false,
              enableVibration: alarm.vibrateEnabled,
              ongoing: true,
              autoCancel: false,
              visibility: NotificationVisibility.public)),
      payload: alarm.id.toString(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: null,
    );
  }

  Future<void> showNotification(int id) async {
    await notifications.show(
        id: id,
        title: 'Notificacion Local',
        body: 'Notificacion Exitosa',
        notificationDetails: NotificationDetails(
            android: AndroidNotificationDetails('alarm-channel', 'alarm',
                importance: Importance.high,
                ongoing: true,
                playSound: true,
                category: AndroidNotificationCategory.alarm,
                enableVibration: true,
                visibility: NotificationVisibility.public)),
        payload: '123');
  }

  Future<void> cancel(int id) async {
    await notifications.cancel(id: id);
  }

  Future<void> cancelAll() async {
    await notifications.cancelAll();
  }

  // DateTime _nextInstance(Alarm alarm) {
  //   final now = DateTime.now();
  //   var scheduled =
  //       DateTime(now.year, now.month, now.day, alarm.hour, alarm.minute);
  //   if (scheduled.isBefore(now)) {
  //     scheduled = scheduled.add(Duration(days: 1));
  //   }
  //   return scheduled;
  // }
}
