import 'package:alarm_play/infrastructure/db/isar_service.dart';
import 'package:alarm_play/infrastructure/providers/service_provider.dart';
import 'package:alarm_play/infrastructure/services/alarm_restore_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final alarmRestoreProvider = Provider<AlarmRestoreService>((ref) {
  final isar = IsarService.instance;
  final alarmScheduler = ref.read(alarmSchedulerProvider);

  return AlarmRestoreService(isar: isar, alarmScheduler: alarmScheduler);
});
