import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../data/entities/entities.dart';

class AlarmSchedulerService {
  final FlutterLocalNotificationsPlugin notifications;

  AlarmSchedulerService(this.notifications);

  // todo filtrar si el schedule date sera antes de hoy y sumarle un dia

  Future<void> scheduleAlarm(Alarm alarm) async {
    if (alarm.nextTrigger == null) return;
    final scheduledDate = tz.TZDateTime.from(alarm.nextTrigger!, tz.local);
    final int idNotification = alarm.id & 0xFFFFFFFF;
    await notifications.zonedSchedule(
      id: idNotification,
      title: 'Alarm',
      body: alarm.label ?? 'Wake up',
      scheduledDate: tz.TZDateTime.from(alarm.nextTrigger!, tz.local),
      notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails('alarm_channel', 'alarms',
              importance: Importance.max,
              priority: Priority.high,
              fullScreenIntent: true,
              audioAttributesUsage: AudioAttributesUsage.alarm,
              category: AndroidNotificationCategory.alarm,
              playSound: false,
              enableVibration: alarm.vibrateEnabled,
              ongoing: true,
              autoCancel: false,
              visibility: NotificationVisibility.public)),
      payload: alarm.id.toString(),
      androidScheduleMode: AndroidScheduleMode.alarmClock,
      matchDateTimeComponents: null,
    );
    print('Scheduled: ${scheduledDate}');
    print('Now: ${tz.TZDateTime.now(tz.local)}');
    print(
        'Difference: ${scheduledDate.difference(tz.TZDateTime.now(tz.local))}');
    checkPendigNotification();
  }

  Future<void> checkPendigNotification() async {
    final pending = await notifications.pendingNotificationRequests();
    print('Pending notification List ${pending.length}');
    for (final p in pending) {
      print('Pending notification id: ${p.id}');
    }
  }

  Future<void> showNotification(int id) async {
    await notifications.show(
        id: id,
        title: 'Notificacion Local',
        body: 'Notificacion Exitosa',
        notificationDetails: NotificationDetails(
            android: AndroidNotificationDetails('alarm-channel', 'alarm',
                importance: Importance.high,
                fullScreenIntent: true,
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
