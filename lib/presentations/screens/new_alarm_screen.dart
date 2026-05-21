import 'package:alarm_play/core/controllers/alarm_controller_provider.dart';
import 'package:alarm_play/core/services/obtain_12hours_service.dart';
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
  final Alarm newAlarm = Alarm(
      hour: TimeOfDay.now().hour,
      minute: TimeOfDay.now().minute,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      repeatDays: [],
      assetPath: 'assets/audiofiles/alarm.mp3',
      playbackMode: PlaybackMode.repeatOne,
      isActive: true,
      playOnce: false,
      vibrateEnabled: true,
      volume: 1.0,
      autoStop: false,
      ascendingVolume: true,
      snoozeMinutes: 10,
      autoStopAfterMinutes: 30);

  @override
  Widget build(BuildContext context) {
    return AlarmWidget(
      alarm: widget.alarm == null ? newAlarm : widget.alarm!,
      title: widget.alarm == null ? 'Crear Alarma' : 'Editar Alarma',
    );
  }
}

class AlarmWidget extends ConsumerStatefulWidget {
  final Alarm alarm;
  final String title;
  const AlarmWidget({super.key, required this.alarm, required this.title});

  @override
  ConsumerState<AlarmWidget> createState() => _AlarmWidgetState();
}

class _AlarmWidgetState extends ConsumerState<AlarmWidget> {
  TimeOfDay? selectedTime;
  bool vibrar = true;
  bool playOnce = false;
  bool autoStop = false;
  bool ascendingVolume = true;
  int snoozeMinutes = 10;
  int autoStopAfter = 30;
  List<int> repeat = [];
  PlaybackMode playBackMode = PlaybackMode.repeatOne;
  double volume = 100;
  final TextEditingController controller = TextEditingController();
  // todo nextTrigger variable

  void acceptAlarm() {
    final alarm = widget.alarm.copyWith(
        hour: selectedTime!.hour,
        minute: selectedTime!.minute,
        ascendingVolume: ascendingVolume,
        assetPath: 'assets/audiofiles/alarm.mp3',
        autoStop: autoStop,
        autoStopAfterMinutes: autoStopAfter,
        isActive: true,
        nextTrigger: DateTime(1).add(Duration(days: 1)),
        playOnce: playOnce,
        playbackMode: playBackMode,
        repeatDays: repeat,
        snoozeMinutes: snoozeMinutes,
        updatedAt: DateTime.now(),
        vibrateEnabled: vibrar,
        volume: volume);
    ref.read(alarmControllerProvider).createAlarm(alarm);
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

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
              onPressed: () => acceptAlarm(), icon: Icon(Icons.check_rounded))
        ],
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                final TimeOfDay? time = await showTimePicker(
                  context: context,
                  initialTime: selectedTime ??
                      TimeOfDay(
                          hour: widget.alarm.minute,
                          minute: widget.alarm.minute),
                  initialEntryMode: TimePickerEntryMode.dial,
                  builder: (context, child) {
                    return child!;
                  },
                );
                setState(() {
                  selectedTime = time;
                });
              },
              child: Text(
                Obtain12hoursService.obtenerFormatoAmPm(selectedTime ??
                    TimeOfDay(
                        hour: widget.alarm.hour, minute: widget.alarm.minute)),
                style: TextStyle(fontSize: 42),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            // esta linea debe ser mas resaltada
            Row(
              children: [Text("Seleccionar playList")],
            ),
            Row(
              children: [
                Text('Vibrar al sonar'),
                Spacer(),
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
                Spacer(),
                Switch(
                  value: playOnce,
                  onChanged: (value) {
                    setState(() {
                      playOnce = !playOnce;
                    });
                  },
                )
              ],
            ),
            Row(
              children: [
                Text('Silenciar durante: '),
                // todo este metodo no seria un switch, simplemente necesito el ingreso del tiempo a silenciar
                // me suena mas, el bool y que desactive el input para el tiempo
                Spacer(),
                SizedBox(
                  width: 60,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: controller,
                    keyboardType: TextInputType.numberWithOptions(),
                    onChanged: (value) {
                      if (value.isEmpty) {
                        snoozeMinutes = widget.alarm.snoozeMinutes;
                      } else {
                        snoozeMinutes = int.parse(controller.text);
                      }
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: widget.alarm.snoozeMinutes.toString()),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Text('Desactivar despues de: '),
                // todo crear el metodo sea false si es cero. y un combinado donde se pueda desactivar y bloquear un input para el tiempo
                // me suena mas, el bool y que desactive el input para el tiempo
                Spacer(),
                Switch(
                  value: autoStop,
                  onChanged: (value) {
                    setState(() {
                      playOnce = !playOnce;
                    });
                  },
                )
              ],
            ),
            // linea de ejemplo, para ingreso de timepo
            Row(
              children: [Text('Minutos'), Spacer(), Text('30')],
            )
            // todo Necesito que este screen cree una Alarm de acuerdo a los inputs. Para guardarla
            // forma de seleccionar hora DONE
            // playList selector
            // repetir
            // vibrar al sonar SWITCH default true Done
            // eliminar despues de sonar SWITCH default false DONE
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          label: Text('Accept'),
          onPressed: () => acceptAlarm(),
          icon: Icon(Icons.add_alarm)),
    );
  }
}
