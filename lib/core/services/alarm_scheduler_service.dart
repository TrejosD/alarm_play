import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../data/entities/entities.dart';

class AlarmSchedulerService {
  final FlutterLocalNotificationsPlugin notifications;

  AlarmSchedulerService(this.notifications);

  Future<void> schedule(Alarm alarm) async {
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
              visibility: NotificationVisibility.public)),
      payload: alarm.id.toString(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: null,
    );
  }

  Future<void> cancel(int id) async {
    await notifications.cancel(id: id);
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
