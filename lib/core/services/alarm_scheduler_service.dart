import 'package:alarm_play/core/controllers/alarm_controller_provider.dart';
import 'package:alarm_play/core/db/isar_service.dart';
import 'package:alarm_play/core/services/alarm_bridge_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/entities/entities.dart';

class AlarmSchedulerService {
  final FlutterLocalNotificationsPlugin notifications;
  final isar = IsarService.instance;
  final Ref ref;
  AlarmSchedulerService(this.notifications, this.ref);

  Future<void> scheduleAlarm(Alarm alarm) async {
    if (!alarm.isActive) return;
    final nextTrigger = alarm.nextTrigger;
    if (nextTrigger == null) return;

    await AlarmBridgeService.scheduleAlarm(
        alarmId: alarm.id!, triggerTime: nextTrigger);
  }
  // Future<void> scheduleAlarm(Alarm alarm) async {
  //   print('Scheduled alarm ${alarm.id}');
  //   print('nextTrigger ${alarm.nextTrigger}');
  //   if (alarm.nextTrigger == null) return;
  //   await notifications.zonedSchedule(
  //     id: alarm.id ?? 1,
  //     title: 'Alarm',
  //     body: alarm.label ?? 'Wake up',
  //     scheduledDate: tz.TZDateTime.from(alarm.nextTrigger!, tz.local),
  //     notificationDetails: NotificationDetails(
  //         android: AndroidNotificationDetails('alarm_channel', 'alarms',
  //             importance: Importance.max,
  //             priority: Priority.high,
  //             fullScreenIntent: true,
  //             category: AndroidNotificationCategory.alarm,
  //             playSound: false,
  //             enableVibration: alarm.vibrateEnabled,
  //             ongoing: true,
  //             autoCancel: false,
  //             visibility: NotificationVisibility.public)),
  //     payload: alarm.id.toString(),
  //     androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //     matchDateTimeComponents: null,
  //   );
  // }
  // Future<void> checkPendigNotification() async {
  //   final pending = await notifications.pendingNotificationRequests();
  //   print('Pending notification List ${pending.length}');
  //   for (final p in pending) {
  //     print('Pending notification id: ${p.id}');
  //   }
  // }

  Future<void> cancelAlarm(int alarmId) async {
    await AlarmBridgeService.cancelAlarm(alarmId: alarmId);
  }

  Future<void> onAlarmFinished(Alarm alarm) async {
    // sonar una vez y eliminar
    if (alarm.playOnce) {
      await ref.read(alarmControllerProvider).deleteAlarm(alarm.id!);
      return;
    }
    // sonar y desactivar
    if (alarm.repeatDays.isEmpty) {
      alarm.isActive = false;
    } else {
      // sonar y recalcular nuevo trigger
      alarm.updateNextTrigger();
      await scheduleAlarm(alarm);
    }
    await isar.writeTxn(() async {
      await isar.alarms.put(alarm);
    });
  }

  Future<void> showNotification(int id) async {
    await notifications.show(
        id: id,
        title: 'Notificacion Local',
        body: 'Notificacion Exitosa',
        notificationDetails: NotificationDetails(
            android: AndroidNotificationDetails('alarm-channel', 'alarm',
                importance: Importance.max,
                fullScreenIntent: true,
                priority: Priority.max,
                ongoing: true,
                playSound: true,
                category: AndroidNotificationCategory.alarm,
                enableVibration: true,
                visibility: NotificationVisibility.public)),
        payload: '123');
  }
}
