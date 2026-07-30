import 'package:alarm_play/infrastructure/db/isar_service.dart';
import 'package:alarm_play/infrastructure/services/alarm_bridge_service.dart';

import '../../data/entities/entities.dart';

// este servicio nos permite calendarizar nuetras alarmas
class AlarmSchedulerService {
  final isar = IsarService.instance;
  AlarmSchedulerService();
// metodo para calendarizar una alarma
  Future<void> scheduleAlarm(Alarm alarm) async {
    if (!alarm.isActive) return;
    final nextTrigger = alarm.nextTrigger;
    if (nextTrigger == null) return;

    await AlarmBridgeService.scheduleAlarm(
        alarmId: alarm.id!, triggerTime: nextTrigger);
  }

// metodo para calendarizar un alarma silenciada. *Este solo genera una siguiente ejecucion UNA VEZ,  sin cambios en DB
  Future<void> scheduleSnoozeAlarm(Alarm alarm, int snoozeTime) async {
    final nextTrigger = alarm.nextTrigger!.add(Duration(minutes: snoozeTime));
    await AlarmBridgeService.scheduleAlarm(
        alarmId: alarm.id!, triggerTime: nextTrigger);
  }

// metodo cancela un alarma triggers
  Future<void> cancelAlarm(int alarmId) async {
    await AlarmBridgeService.cancelAlarm(alarmId: alarmId);
  }

// metodo elimina un alarma del DB y cancela sus triggers
  Future<void> deleteAlarm(int alarmId) async {
    await cancelAlarm(alarmId);
    await isar.writeTxn(() async {
      await isar.alarms.delete(alarmId);
    });
  }

// metodo se ejecuta al finalizar un alarma, *Revisa si debe eliminarse (playOnce activo), si debe agendarse de nuevo (alarma con dias de repeticion), o si debe cancelarse y mantenerse en DB
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
