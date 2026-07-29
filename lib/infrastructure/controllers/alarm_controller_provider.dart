import 'package:alarm_play/infrastructure/db/isar_service.dart';
import 'package:alarm_play/infrastructure/providers/service_provider.dart';
import 'package:alarm_play/infrastructure/services/alarm_scheduler_service.dart';
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

  Future<void> scheduleAlarm(Alarm alarm) async {
    await scheduler.scheduleAlarm(alarm);
  }

  Future<void> scheduleSnoozeAlarm(Alarm alarm, int snoozeTime) async {
    await scheduler.scheduleSnoozeAlarm(alarm, snoozeTime);
  }

  Future<void> stopAlarm(Alarm alarm) async {
    await scheduler.cancelAlarm(alarm.id!);
    await scheduler.onAlarmFinished(alarm);
  }
}
