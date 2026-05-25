import 'package:alarm_play/core/controllers/alarm_controller_provider.dart';
import 'package:alarm_play/core/services/obtain_12hours_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/entities/entities.dart';

class AlarmCard extends ConsumerWidget {
  final Alarm alarm;
  const AlarmCard({super.key, required this.alarm});

  @override
  Widget build(BuildContext context, ref) {
    final selectedTime = TimeOfDay(hour: alarm.hour, minute: alarm.minute);
    final now = DateTime.now();
    final DateTime selectedDateTime = DateTime(
        now.year, now.month, now.day, selectedTime.hour, selectedTime.minute);
    final nextRing = selectedDateTime
        .subtract(Duration(hours: now.hour, minutes: now.minute));
    return ListTile(
      leading: IconButton(
        onPressed: () {
          ref.read(alarmControllerProvider).deleteAlarm(alarm.id);
        },
        icon: Icon(Icons.delete_forever_outlined),
      ),
      subtitle: Column(
        children: [
          Row(children: [Text('Repeticion: '), Text('${alarm.repeatDays}')]),
          Row(children: [
            Text('Sonará dentro de: '),
            Text('${nextRing.hour}: ${nextRing.minute} hrs')
          ]),
          Text('Song / PlayList Name'),
        ],
      ),
      title: Row(
        children: [
          Text(
            Obtain12hoursService.obtenerFormatoAmPm(selectedTime),
            style: TextStyle(fontSize: 23),
          ),
          Spacer(),
          Switch(
              value: alarm.isActive,
              onChanged: (_) {
                ref.read(alarmControllerProvider).toggleAlarm(alarm);
              }),
        ],
      ),
    );
  }
}
