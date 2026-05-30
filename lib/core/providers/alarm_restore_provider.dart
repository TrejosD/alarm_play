import 'package:alarm_play/core/db/isar_service.dart';
import 'package:alarm_play/core/providers/service_provider.dart';
import 'package:alarm_play/core/services/alarm_restore_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final alarmRestoreProvider = Provider<AlarmRestoreService>((ref) {
  final isar = IsarService.instance;
  final alarmScheduler = ref.read(alarmSchedulerProvider);

  return AlarmRestoreService(isar: isar, alarmScheduler: alarmScheduler);
});
