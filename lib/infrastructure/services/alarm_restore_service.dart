// este servicio permite que las alarmas se re-agenden en caso de cambios de zona horaria, hora del telefono, reinicio ...

import 'package:alarm_play/data/entities/alarm_entity.dart';
import 'package:isar/isar.dart';

import 'services.dart';

class AlarmRestoreService {
  final Isar isar;
  final AlarmSchedulerService alarmScheduler;

  AlarmRestoreService({required this.isar, required this.alarmScheduler});

  Future<void> restoreAllActiveAlarms() async {
    final alarms = isar.alarms.filter().isActiveEqualTo(true).findAll();
    for (final alarm in await alarms) {
      try {
        // recalcular siempre
        alarm.updateNextTrigger();
        // cancelar las alarmas pendientes
        await alarmScheduler.cancelAlarm(alarm.id!);
        // guardar nuevo trigger
        await isar.writeTxn(() async {
          await isar.alarms.put(alarm);
        });
        // programar nuevamente
        await alarmScheduler.scheduleAlarm(alarm);
      } catch (e) {
        print(
          'Error rescheduling alarm ${alarm.id} $e',
        );
      }
    }
  }
}
