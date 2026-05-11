import 'package:alarm_play/data/entities/entities.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentRingingAlarmProvider = StateProvider<Alarm?>((ref) => null);
