import 'package:alarm_play/core/db/isar_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../data/entities/entities.dart';

final alarmControllerProvider = Provider<AlarmController>((ref) {
  return AlarmController(ref);
});

class AlarmController {
  final Ref ref;
  final isar = IsarService.instance;

  AlarmController(this.ref);

  Future<void> createAlarm(Alarm alarm) async {
    alarm.updateNextTrigger();
    await isar.writeTxn(() async {
      await isar.alarms.put(alarm);
    });
    if (alarm.isActive) {
      await scheduleAlarm(alarm);
    }
  }

  Future<void> onAlarmFinished(Alarm alarm) async {
    // sonar una vez & delete
    if (alarm.playOnce) {
      await deleteAlarm(alarm.id);
      return;
    }
    // sonar y desactiva
    if (alarm.repeatDays.isEmpty) {
      alarm.isActive = false;
    }
    // sonar y programar siguiente
    else {
      alarm.updateNextTrigger();
      await scheduleAlarm(alarm);
    }
    await isar.writeTxn(() async {
      await isar.alarms.put(alarm);
    });
  }

  Future<void> updateAlarm(Alarm alarm) async {
    alarm.updateNextTrigger();
    await isar.writeTxn(() async {
      await isar.alarms.put(alarm);
    });

    if (alarm.isActive) {
      await cancelAlarm(alarm.id);
      await scheduleAlarm(alarm);
    }
  }

  Future<void> deleteAlarm(Id? id) async {
    if (id == null) return;
    await cancelAlarm(id);
    await isar.writeTxn(() async {
      await isar.alarms.delete(id);
    });
  }

  Future<void> toggleAlarm(Alarm alarm) async {
    alarm.isActive = !alarm.isActive;
    if (alarm.isActive) {
      alarm.updateNextTrigger();
    }
    await isar.writeTxn(() async {
      await isar.alarms.put(alarm);
    });
    if (alarm.isActive) {
      await scheduleAlarm(alarm);
    } else {
      await cancelAlarm(alarm.id);
    }
  }

  Future<void> onAlarmTriggered(Id alarmId) async {
    final alarm = await isar.alarms.get(alarmId);
    if (alarm == null) return;
    if (alarm.repeatDays.isEmpty) {
      // una vez
      alarm.isActive = false;
    } else {
      // calcular siguiente
      alarm.calculateNextTrigger();
      await scheduleAlarm(alarm);
    }
    await isar.writeTxn(() async {
      await isar.alarms.put(alarm);
    });
  }

  Future<void> scheduleAlarm(Alarm alarm) async {}
  Future<void> cancelAlarm(int? id) async {
    if (id == null) return;
    Alarm? alarm = await isar.alarms.get(id);
    if (alarm == null) return;
    alarm = alarm.copyWith(isActive: false);
    await isar.writeTxn(() async {
      await isar.alarms.put(alarm!);
    });
  }
}
