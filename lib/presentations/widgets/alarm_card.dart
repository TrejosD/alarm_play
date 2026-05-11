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
        onPressed: () {},
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
          Text('06:00 am'),
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
