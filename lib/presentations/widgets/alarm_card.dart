import 'package:alarm_play/infrastructure/controllers/alarm_controller_provider.dart';
import 'package:alarm_play/infrastructure/providers/playlist_repository_provider.dart';
import 'package:alarm_play/infrastructure/services/obtain_12hours_service.dart';
import 'package:alarm_play/presentations/providers/days_repeat_map_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/entities/entities.dart';

// este widget creamos la tarjeta para mostrar cada alarma creada
class AlarmCard extends ConsumerStatefulWidget {
  final Alarm alarm;
  const AlarmCard({super.key, required this.alarm});

  @override
  ConsumerState<AlarmCard> createState() => _AlarmCardState();
}

class _AlarmCardState extends ConsumerState<AlarmCard> {
  Playlist playlist = Playlist();
  List<int> selectedDays = [];
  // metodo encuentra la playList, basado en su ID
  Future<void> findPlaylist(int id) async {
    final newPlaylist = await ref.read(playlistRepositoryProvider).getById(id);
    if (newPlaylist != null) {
      playlist = newPlaylist;
    } else {
      playlist = Playlist()..name = 'Unknown playlist';
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    findPlaylist(widget.alarm.playlistId);
    selectedDays = widget.alarm.repeatDays;
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle style = TextStyle(fontWeight: FontWeight(600));
    final selectedTime =
        TimeOfDay(hour: widget.alarm.hour, minute: widget.alarm.minute);
    // mapa para hacer correspondecia entre el dia seleccionado y un valor int
    final days = ref.read(dayRepeatMapProvider);
// este metodo permite calcular en cuanto tiempo sonara la alarma
    DateTime getNextRingTime() {
      final now = DateTime.now();
      final DateTime selectedDateTime = DateTime(
          now.year, now.month, now.day, selectedTime.hour, selectedTime.minute);
      final nextRing = selectedDateTime
          .subtract(Duration(hours: now.hour, minutes: now.minute));
      return nextRing;
    }

    return ListTile(
      leading: IconButton(
        onPressed: () {
          ref.read(alarmControllerProvider).deleteAlarm(widget.alarm.id!);
        },
        icon: Icon(Icons.delete_forever_outlined),
      ),
      subtitle: Column(
        children: [
          Row(children: [
            // actualmente, este wrap, toma siempre la lista de days, y en base a que dias estan seleccionados muestra la seleccion.
            Wrap(
                spacing: 1,
                children: selectedDays.map((day) {
                  final coincidencia =
                      days.firstWhere((item) => item['value'] == day);
                  final String label = coincidencia['label'];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.purple.shade300,
                          borderRadius: BorderRadius.circular(8)),
                      height: 36,
                      width: 32,
                      child: Center(child: Text(label)),
                    ),
                  );
                }).toList())
          ]),
          widget.alarm.isActive
              ? StreamBuilder(
                  stream: Stream.periodic(const Duration(seconds: 30)),
                  builder: (context, snapshot) {
                    final ringTime = getNextRingTime();
                    return Row(children: [
                      Text(
                        'Sonará dentro de: ',
                        style: style,
                      ),
                      Text('${ringTime.hour}hrs : ${ringTime.minute} min')
                    ]);
                  },
                )
              : Row(
                  children: [
                    Text(
                      'Alarma desactivada',
                      style: style,
                    ),
                  ],
                ),
          Row(
            children: [
              Text(
                'PlayList: ',
                style: style,
              ),
              Text(playlist.name ?? ''),
            ],
          )
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
              value: widget.alarm.isActive,
              onChanged: (_) {
                ref.read(alarmControllerProvider).toggleAlarm(widget.alarm);
              }),
        ],
      ),
    );
  }
}
