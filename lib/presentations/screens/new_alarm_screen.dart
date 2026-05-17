import 'package:alarm_play/core/controllers/alarm_controller_provider.dart';
import 'package:alarm_play/data/entities/alarm_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewAlarmScreen extends ConsumerStatefulWidget {
  final Alarm? alarm;
  const NewAlarmScreen({super.key, this.alarm});

  @override
  ConsumerState<NewAlarmScreen> createState() => _NewAlarmScreenState();
}

class _NewAlarmScreenState extends ConsumerState<NewAlarmScreen> {
  TimeOfDay? selectedTime;
  bool vibrar = true;
  bool playOnce = false;
  bool ascendingVolume = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.cancel_rounded)),
        actions: [
          IconButton(
              onPressed: () {
                Alarm newAlarm = Alarm(
                    id: widget.alarm!.id,
                    label: widget.alarm!.label,
                    hour: selectedTime!.hour,
                    minute: selectedTime!.minute,
                    ascendingVolume: ascendingVolume,
                    assetPath: 'assets/audiofiles/alarm.mp3',
                    autoStop: false,
                    autoStopAfterMinutes: 20,
                    createdAt: DateTime.now(),
                    isActive: true,
                    nextTrigger: DateTime(1).add(Duration(days: 1)),
                    playOnce: playOnce,
                    playbackMode: PlaybackMode.repeatOne,
                    repeatDays: [1234],
                    snoozeMinutes: 10,
                    updatedAt: DateTime.now(),
                    vibrateEnabled: vibrar,
                    volume: 100);
                ref.read(alarmControllerProvider).createAlarm(newAlarm);
                // widget.alarm puede ser null. Entonces, la newAlarm puede tomar el id del widget.alarm y si no exite no importa isar lo crea.
                // todo metod crear ACCEPT alarma
              },
              icon: Icon(Icons.check_rounded))
        ],
        title:
            widget.alarm != null ? Text('Editar alarma') : Text('Crear alarma'),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () async {
              final TimeOfDay? time = await showTimePicker(
                context: context,
                initialTime: selectedTime ?? TimeOfDay.now(),
                initialEntryMode: TimePickerEntryMode.input,
                builder: (context, child) {
                  return child!;
                },
              );
              setState(() {
                selectedTime = time;
              });
            },
            child: Text('${selectedTime ?? TimeOfDay.now()}'),
            // todo crear human time layout
          ),
          Row(
            children: [
              Text('Vibrar al sonar'),
              Switch(
                value: vibrar,
                onChanged: (value) {
                  setState(() {
                    vibrar = !vibrar;
                  });
                },
              )
            ],
          ),
          Row(
            children: [
              Text('Eliminar despues de sonar'),
              Switch(
                value: playOnce,
                onChanged: (value) {
                  setState(() {
                    playOnce = !playOnce;
                  });
                },
              )
            ],
          )
          // todo Necesito que este screen cree una Alarm de acuerdo a los inputs. Para guardarla
          // forma de seleccionar hora DONE
          // playList selector
          // repetir
          // vibrar al sonar SWITCH default true Done
          // eliminar despues de sonar SWITCH default false DONE
        ],
      ),
    );
  }
}
