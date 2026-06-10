// responsabilidad escuchar MethodChannel
import 'package:flutter/services.dart';

class AlarmBridgeService {
  static const _channel = MethodChannel('alarm_play/alarm');

  static Future<void> triggerAlarm() async {
    await _channel.invokeMethod('triggerAlarm');
  }

  static Future<void> scheduleAlarm(
      {required int alarmId, required DateTime triggerTime}) async {
    print('scheduleAlarm desde alarmService');
    await _channel.invokeMethod('scheduleAlarm', {
      'alarmId': alarmId,
      'triggerMillis': triggerTime.millisecondsSinceEpoch
    });
  }
}
