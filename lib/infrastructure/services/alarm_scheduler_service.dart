import 'package:alarm_play/infrastructure/db/isar_service.dart';
import 'package:alarm_play/infrastructure/services/alarm_bridge_service.dart';

import '../../data/entities/entities.dart';

class AlarmSchedulerService {
  final isar = IsarService.instance;
  AlarmSchedulerService();

  Future<void> scheduleAlarm(Alarm alarm) async {
    if (!alarm.isActive) return;
    final nextTrigger = alarm.nextTrigger;
    if (nextTrigger == null) return;

    await AlarmBridgeService.scheduleAlarm(
        alarmId: alarm.id!, triggerTime: nextTrigger);
  }

  Future<void> scheduleSnoozeAlarm(Alarm alarm, int snoozeTime) async {
    final nextTrigger = alarm.nextTrigger!.add(Duration(minutes: snoozeTime));
    print('Alarm ${alarm.id} will start on: ${nextTrigger}');
    await AlarmBridgeService.scheduleAlarm(
        alarmId: alarm.id!, triggerTime: nextTrigger);
  }

  Future<void> cancelAlarm(int alarmId) async {
    await AlarmBridgeService.cancelAlarm(alarmId: alarmId);
  }

  Future<void> deleteAlarm(int alarmId) async {
    await cancelAlarm(alarmId);
    await isar.writeTxn(() async {
      await isar.alarms.delete(alarmId);
    });
  }

  Future<void> onAlarmFinished(Alarm alarm) async {
    // sonar una vez y eliminar
    if (alarm.playOnce) {
      await deleteAlarm(alarm.id!);
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
}
