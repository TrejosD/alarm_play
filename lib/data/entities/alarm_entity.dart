import 'package:isar/isar.dart';

part 'alarm_entity.g.dart';

@collection
class Alarm {
  // id lo ingresa Isar
  Id? id = Isar.autoIncrement;
  // label no es necesario, podemos utilizarlo para indentificacion futura, como un identifier para el usuario
  String? label;
// horario de la alerta
  late int hour;
  late int minute;
// horario de creacion y edicion
  late DateTime createdAt;
  late DateTime updatedAt;
// dias a sonar la alarma
  late List<int> repeatDays; // 1-7
// ruta de archivo sonido - sera Innecesario
  late String? defaultSound;
  // late int playlistId;
  late int playlistId;
  // forma de reproduccion de sonido
  @enumerated
  late PlaybackMode playbackMode;
// esta activa la alarma
  late bool isActive;
// sonara y se eliminara auto
  bool playOnce = false;
  // vibracion activada?
  bool vibrateEnabled = true;
// valor del volumen
  double volume = 1.0;
  // el volumen es ascedente?
  bool ascendingVolume = false;
// tiempo que la alarma de pausa
  int snoozeMinutes = 10;
// alarma suena y se coloca inActive. No se elimina solo se desactiva
  bool autoStop = false;
// tiempo en que la alarma se desactiva auto
  int autoStopAfterMinutes = 30;
  // fecha siguiente alarma
  DateTime? nextTrigger;

  Alarm(
      {this.id,
      this.label,
      required this.hour,
      required this.minute,
      required this.createdAt,
      required this.updatedAt,
      required this.repeatDays,
      required this.defaultSound,
      required this.playlistId,
      required this.playbackMode,
      required this.isActive,
      required this.playOnce,
      required this.vibrateEnabled,
      required this.volume,
      required this.autoStop,
      required this.ascendingVolume,
      required this.snoozeMinutes,
      required this.autoStopAfterMinutes,
      this.nextTrigger});

  Alarm copyWith(
          {Id? id,
          String? label,
          int? hour,
          int? minute,
          DateTime? createdAt,
          DateTime? updatedAt,
          List<int>? repeatDays,
          String? defaultSound,
          int? playlistId,
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
          label: label ?? this.label,
          hour: hour ?? this.hour,
          minute: minute ?? this.minute,
          createdAt: createdAt ?? this.createdAt,
          updatedAt: updatedAt ?? this.updatedAt,
          repeatDays: repeatDays ?? this.repeatDays,
          defaultSound: defaultSound ?? this.defaultSound,
          playlistId: playlistId ?? this.playlistId,
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

enum PlaybackMode { shuffle, sequential }

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

// llamar este metodo para actualizar las alarmas NextTrigger
extension AlarmLifecycle on Alarm {
  void updateNextTrigger() {
    nextTrigger = this.calculateNextTrigger();
    updatedAt = DateTime.now();
  }
}
