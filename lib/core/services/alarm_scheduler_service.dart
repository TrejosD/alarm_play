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

// todo revisar el nextTrigger se ejecute correctamente
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
      alarm.calculateNextTrigger();
      await scheduleAlarm(alarm);
    }
    await isar.writeTxn(() async {
      await isar.alarms.put(alarm);
    });
    print('Desde onAlarmFinished - alarm: ${alarm.nextTrigger}');
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
}
