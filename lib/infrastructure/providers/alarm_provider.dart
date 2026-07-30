import 'package:alarm_play/infrastructure/db/isar_service.dart';
import 'package:alarm_play/data/entities/alarm_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

// este stream provider nos emite la lista de alarmas
final alarmsProvider = StreamProvider<List<Alarm>>((ref) {
  final isar = IsarService.instance;
  return isar.alarms.where().sortByNextTrigger().watch(fireImmediately: true);
});
