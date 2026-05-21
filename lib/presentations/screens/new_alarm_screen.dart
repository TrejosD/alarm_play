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
  late Alarm newAlarm;
  TimeOfDay? selectedTime = TimeOfDay.now();
  bool vibrar = true;
  bool playOnce = false;
  bool autoStop = false;
  bool ascendingVolume = true;
  int snoozeMinutes = 10;
  List<int> repeat = [];
  PlaybackMode playBackMode = PlaybackMode.repeatOne;
  double volume = 100;
  // todo nextTrigger variable
  @override
  void initState() {
    super.initState();
    // se iguala widged.alarm al newAlarm si existe. ?? Sino existe alarm. Se crea una nueva. Para trabajar solamente con el objeto newAlarm
    if (widget.alarm == null) {
      newAlarm = Alarm(
          label: 'new',
          hour: selectedTime!.hour,
          minute: selectedTime!.minute,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          repeatDays: repeat,
          assetPath: 'assets/audiofiles/alarm.mp3',
          playbackMode: playBackMode,
          isActive: true,
          playOnce: playOnce,
          vibrateEnabled: vibrar,
          volume: volume,
          autoStop: autoStop,
          ascendingVolume: ascendingVolume,
          snoozeMinutes: snoozeMinutes,
          autoStopAfterMinutes: 20,
          nextTrigger: DateTime(1).add(Duration(days: 1)));
    } else {
      newAlarm = widget.alarm!;
      selectedTime =
          TimeOfDay(hour: widget.alarm!.hour, minute: widget.alarm!.minute);
    }
  }

  void acceptAlarm() {
    final alarm = newAlarm.copyWith(
        hour: selectedTime!.hour,
        minute: selectedTime!.minute,
        ascendingVolume: ascendingVolume,
        assetPath: 'assets/audiofiles/alarm.mp3',
        autoStop: autoStop,
        autoStopAfterMinutes: 20,
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
    final TextEditingController controller = TextEditingController();
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
        title:
            widget.alarm != null ? Text('Editar alarma') : Text('Crear alarma'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                final TimeOfDay? time = await showTimePicker(
                  context: context,
                  initialTime: selectedTime ?? TimeOfDay.now(),
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
                Obtain12hoursService.obtenerFormatoAmPm(
                    selectedTime ?? TimeOfDay.now()),
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
                    controller: controller,
                    keyboardType: TextInputType.numberWithOptions(),
                    onChanged: (value) {
                      snoozeMinutes = int.parse(controller.text);
                    },
                    decoration: InputDecoration(
                        hintText: newAlarm.snoozeMinutes.toString()),
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
