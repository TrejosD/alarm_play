// responsabilidad escuchar MethodChannel
import 'package:flutter/services.dart';

class AlarmBridgeService {
  static const _channel = MethodChannel('alarm_play/alarm');

  static Future<void> triggerAlarm() async {
    await _channel.invokeMethod('triggerAlarm');
  }
}
