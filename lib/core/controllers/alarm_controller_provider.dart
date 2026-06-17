import 'package:alarm_play/core/db/isar_service.dart';
import 'package:alarm_play/core/providers/service_provider.dart';
import 'package:alarm_play/core/services/alarm_scheduler_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/entities/entities.dart';

final alarmControllerProvider = Provider<AlarmController>((ref) {
  return AlarmController(ref);
});

class AlarmController {
  final Ref ref;
  final isar = IsarService.instance;
  AlarmController(this.ref);

  AlarmSchedulerService get scheduler => ref.read(alarmSchedulerProvider);

  Future<void> createAlarm(Alarm alarm) async {
    alarm.updateNextTrigger();
    await isar.writeTxn(() async {
      await isar.alarms.put(alarm);
    });
    if (alarm.isActive) {
      await scheduleAlarm(alarm);
    }
  }

  Future<void> toggleAlarm(Alarm alarm) async {
    alarm.isActive = !alarm.isActive;
    if (alarm.isActive) {
      alarm.updateNextTrigger();
      await isar.writeTxn(() async {
        await isar.alarms.put(alarm);
      });
      await scheduleAlarm(alarm);
    } else {
      await scheduler.cancelAlarm(alarm.id!);
      await isar.writeTxn(() async {
        await isar.alarms.put(alarm);
      });
    }
  }

  Future<void> deleteAlarm(int alarmId) async {
    await scheduler.cancelAlarm(alarmId);
    await isar.writeTxn(() async {
      await isar.alarms.delete(alarmId);
    });
  }

// todo revisar la logica de este metodo, ya que estaba echo para las localNotifications
  Future<void> updateAlarm(Alarm alarm) async {
    alarm.updateNextTrigger();
    await isar.writeTxn(() async {
      await isar.alarms.put(alarm);
    });

    if (alarm.isActive) {
      await stopAlarm(alarm);
      await scheduleAlarm(alarm);
    }
  }

  Future<void> scheduleAlarm(Alarm alarm) async {
    await scheduler.scheduleAlarm(alarm);
  }

  Future<void> stopAlarm(Alarm alarm) async {
    await scheduler.cancelAlarm(alarm.id!);
    await scheduler.onAlarmFinished(alarm);
  }
}
