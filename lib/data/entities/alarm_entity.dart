import 'package:isar/isar.dart';

part 'alarm_entity.g.dart';

@collection
class Alarm {
  Id? id = Isar.autoIncrement;
  String? label;

  late int hour;
  late int minute;

  late DateTime createdAt;
  late DateTime updatedAt;

  late List<int> repeatDays; // 1-7

  String assetPath = 'assets/audiofiles/alarm.mp3';

  // late int playlistId;
  @enumerated
  late PlaybackMode playbackMode;

  late bool isActive;

  bool playOnce = false;
  bool vibrateEnabled = true;

  double volume = 1.0;
  bool ascendingVolume = false;

  int snoozeMinutes = 10;

  bool autoStop = false;
  int autoStopAfterMinutes = 30;
  DateTime? nextTrigger;

  Alarm(
      {required this.id,
      required this.label,
      required this.hour,
      required this.minute,
      required this.createdAt,
      required this.updatedAt,
      required this.repeatDays,
      required this.assetPath,
      required this.playbackMode,
      required this.isActive,
      required this.playOnce,
      required this.vibrateEnabled,
      required this.volume,
      required this.autoStop,
      required this.ascendingVolume,
      required this.snoozeMinutes,
      required this.autoStopAfterMinutes,
      required this.nextTrigger});

  Alarm copyWith(
          {Id? id,
          String? label,
          int? hour,
          int? minute,
          DateTime? createdAt,
          DateTime? updatedAt,
          List<int>? repeatDays,
          String? assetPath,
          PlaybackMode? playbackMode,
          bool? isActive,
          bool? playOnce,
          bool? vibrateEnabled,
          double? volume,
          bool? ascendingVolume,
          int? snoozeMinutes,
          bool? autoStop,
          int? autoStopAfterMinutes,
          DateTime? nextTrigger}) =>
      Alarm(
          id: id ?? this.id,
          label: label ?? this.label,
          hour: hour ?? this.hour,
          minute: minute ?? this.minute,
          createdAt: createdAt ?? this.createdAt,
          updatedAt: updatedAt ?? this.updatedAt,
          repeatDays: repeatDays ?? this.repeatDays,
          assetPath: assetPath ?? this.assetPath,
          playbackMode: playbackMode ?? this.playbackMode,
          isActive: isActive ?? this.isActive,
          playOnce: playOnce ?? this.playOnce,
          vibrateEnabled: vibrateEnabled ?? this.vibrateEnabled,
          volume: volume ?? this.volume,
          ascendingVolume: ascendingVolume ?? this.ascendingVolume,
          snoozeMinutes: snoozeMinutes ?? this.snoozeMinutes,
          autoStop: autoStop ?? this.autoStop,
          autoStopAfterMinutes:
              autoStopAfterMinutes ?? this.autoStopAfterMinutes,
          nextTrigger: nextTrigger ?? this.nextTrigger);
}

enum PlaybackMode { shuffle, sequential, repeatOne }

DateTime calculateNextTrigger(Alarm alarm) {
  final now = DateTime.now();

  if (alarm.repeatDays.isEmpty) {
    return _nextOneShot(alarm, now);
  }

  return _nextWithRepeat(alarm, now);
}

DateTime _nextOneShot(Alarm? alarm, DateTime now) {
  if (alarm == null) {
    return DateTime.now();
  }
  final scheduled = DateTime(
    now.year,
    now.month,
    now.day,
    alarm.hour,
    alarm.minute,
  );

  if (scheduled.isAfter(now)) {
    return scheduled;
  }

  return scheduled.add(const Duration(days: 1));
}

DateTime _nextWithRepeat(Alarm? alarm, DateTime now) {
  if (alarm == null) return DateTime.now();
  for (int i = 0; i < 7; i++) {
    final canditateDay = now.add(Duration(days: i));
    final weekDay = canditateDay.weekday;
    if (!alarm.repeatDays.contains(weekDay)) continue;
    final scheduled = DateTime(
      canditateDay.year,
      canditateDay.month,
      canditateDay.day,
      alarm.hour,
      alarm.minute,
    );

    if (scheduled.isAfter(now)) {
      return scheduled;
    }
  }
  // esto no deberia suceder, pero por seguridad
  return now.add(const Duration(days: 1));
}

extension AlarmScheduling on Alarm {
  DateTime calculateNextTrigger() {
    final now = DateTime.now();

    if (repeatDays.isEmpty) {
      return _nextOneShot(now);
    } else {
      return _nextWithRepeat(now);
    }
  }

  DateTime _nextOneShot(DateTime now) {
    final scheduled = DateTime(now.year, now.month, now.day, hour, minute);
    if (scheduled.isAfter(now)) {
      return scheduled;
    }
    return scheduled.add(const Duration(days: 1));
  }

  DateTime _nextWithRepeat(DateTime now) {
    for (int i = 0; i < 7; i++) {
      final candidateDay = now.add(Duration(days: i));
      final weekday = candidateDay.weekday;
      if (!repeatDays.contains(weekday)) continue;
      final scheduled = DateTime(
        candidateDay.year,
        candidateDay.month,
        candidateDay.day,
        hour,
        minute,
      );
      if (scheduled.isAfter(now)) {
        return scheduled;
      }
    }
    return now.add(const Duration(days: 1));
  }
}

extension AlarmLifecycle on Alarm {
  void updateNextTrigger() {
    // nextTrigger = calculateNextTrigger(Alarm());
    updatedAt = DateTime.now();
  }
}
