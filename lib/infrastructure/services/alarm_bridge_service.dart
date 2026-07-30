// responsabilidad escuchar MethodChannel
import 'package:flutter/services.dart';

// este servicio nos permite conectar flutter con java nativo de android.
class AlarmBridgeService {
  static const _channel = MethodChannel('alarm_play/alarm');
// metodo para ejecutar un alarma
  static Future<void> triggerAlarm() async {
    await _channel.invokeMethod('triggerAlarm');
  }

// metodo para calendarizar un alarma
  static Future<void> scheduleAlarm(
      {required int alarmId, required DateTime triggerTime}) async {
    await _channel.invokeMethod('scheduleAlarm', {
      'alarmId': alarmId,
      'triggerMillis': triggerTime.millisecondsSinceEpoch
    });
  }

// metodo para cancelar un alarma
  static Future<void> cancelAlarm({required int alarmId}) async {
    await _channel.invokeMethod('cancelAlarm', {'alarmId': alarmId});
  }
}
