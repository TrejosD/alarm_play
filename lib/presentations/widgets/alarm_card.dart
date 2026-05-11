import 'package:alarm_play/core/controllers/alarm_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/entities/entities.dart';

class AlarmCard extends ConsumerWidget {
  final Alarm alarm;
  const AlarmCard({super.key, required this.alarm});

  @override
  Widget build(BuildContext context, ref) {
    return ListTile(
      leading: IconButton(
        onPressed: () {
          ref.read(alarmControllerProvider).deleteAlarm(alarm.id);
        },
        icon: Icon(Icons.delete_forever_outlined),
      ),
      subtitle: Column(
        children: [
          Row(children: [Text('Repeticion'), Text('Sonara dentro de XXX')]),
          Text('Song / PlayList Name'),
        ],
      ),
      title: Row(
        children: [
          Text('${alarm.hour} : ${alarm.minute.toString().padLeft(2, '0')}'),
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
