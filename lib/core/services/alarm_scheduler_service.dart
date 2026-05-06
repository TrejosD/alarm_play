import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../data/entities/entities.dart';

class AlarmSchedulerService {
  final FlutterLocalNotificationsPlugin notifications;

  AlarmSchedulerService(this.notifications);

  Future<void> schedule(Alarm alarm) async {
    final scheduleDate = _nextInstance(alarm);
// todo importar timeZone local notifications as TZ
    await notifications.zonedSchedule(
      id: alarm.id,
      title: 'Alarm',
      body: 'Wake up',
      scheduledDate: scheduleDate,
      notificationDetails: _details(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: null,
    );
  }

  // todo crear metodo _details

  Future<void> cancel(int id) async {
    await notifications.cancel(id: id);
  }

  DateTime _nextInstance(Alarm alarm) {
    final now = DateTime.now();
    var scheduled =
        DateTime(now.year, now.month, now.day, alarm.hour, alarm.minute);
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(Duration(days: 1));
    }
    return scheduled;
  }
}
