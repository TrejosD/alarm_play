// ese servicio registra y maneja las alarmas enviadas de android hacia flutter

import 'package:flutter/services.dart';

class AlarmEventService {
  static const EventChannel _eventChannel =
      EventChannel('alarm_play/alarm_events');

  Stream<int> get alarmStream =>
      _eventChannel.receiveBroadcastStream().map((event) => event as int);
}
