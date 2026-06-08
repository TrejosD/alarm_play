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

final time = TimeOfDay.now();

class _NewAlarmScreenState extends ConsumerState<NewAlarmScreen> {
  final Alarm newAlarm = Alarm(
      hour: time.hour,
      minute: time.minute,
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
      // siempre se envia una alarma, newAlarm la default para crear nueva, y widger.alarm para editar
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
  late int id;
  late bool vibrar;
  late bool playOnce;
  late bool autoStop;
  late bool ascendingVolume;
  late int snoozeMinutes;
  late int autoStopAfter;
  late PlaybackMode playBackMode;
  late double volume;
  late List<int> selectedDays;
  // DateTime? nexTrigger = widget.alarm.nextTrigger;
  final TextEditingController snoozeCtrller = TextEditingController();
  final TextEditingController stopCtrller = TextEditingController();

  @override
  void initState() {
    super.initState();
    id = widget.alarm.id;
    selectedDays = widget.alarm.repeatDays;
    vibrar = widget.alarm.vibrateEnabled;
    playOnce = widget.alarm.playOnce;
    autoStop = widget.alarm.autoStop;
    ascendingVolume = widget.alarm.ascendingVolume;
    snoozeMinutes = widget.alarm.snoozeMinutes;
    autoStopAfter = widget.alarm.autoStopAfterMinutes;
    playBackMode = widget.alarm.playbackMode;
    volume = widget.alarm.volume;
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> daysConfig = [
      {'label': 'L', 'value': 1},
      {'label': 'M', 'value': 2},
      {'label': 'K', 'value': 3},
      {'label': 'J', 'value': 4},
      {'label': 'V', 'value': 5},
      {'label': 'S', 'value': 6},
      {'label': 'D', 'value': 7},
    ];

    void toggleDay(int dayValue) {
      // final days = [...ref.read(selectedDaysProvider)];
      if (selectedDays.contains(dayValue)) {
        selectedDays.remove(dayValue);
      } else {
        selectedDays.add(dayValue);
      }
      setState(() {
        selectedDays.sort();
      });
    }

    void acceptAlarm() {
      selectedTime ??
          {
            selectedTime = TimeOfDay(
                hour: DateTime.now().hour, minute: DateTime.now().minute)
          };
      final trigeredAlarm = widget.alarm
          .copyWith(hour: selectedTime!.hour, minute: selectedTime!.minute);
      final nexTrigger = trigeredAlarm.calculateNextTrigger();
      final alarm = widget.alarm.copyWith(
          hour: selectedTime!.hour,
          minute: selectedTime!.minute,
          ascendingVolume: ascendingVolume,
          assetPath: 'assets/audiofiles/alarm.mp3',
          autoStop: autoStop,
          autoStopAfterMinutes: autoStopAfter,
          isActive: true,
          nextTrigger: nexTrigger,
          playOnce: playOnce,
          playbackMode: playBackMode,
          repeatDays: selectedDays,
          snoozeMinutes: snoozeMinutes,
          updatedAt: DateTime.now(),
          vibrateEnabled: vibrar,
          volume: volume);
      ref.read(alarmControllerProvider).createAlarm(alarm);
      ref.read(alarmControllerProvider).scheduleAlarm(alarm);
      alarm.calculateNextTrigger();
      print('Next trigger ${alarm.nextTrigger}');
      if (mounted) {
        Navigator.of(context).pop();
      }
    }

    void setNewSnoozeNStopTime(String value, int time, int alarmTime,
        TextEditingController controller, String indicator) {
      if (value.isEmpty) return;
      if (indicator == 'snooze') {
        setState(() {
          snoozeMinutes = int.parse(controller.text);
        });
      } else {
        setState(() {
          autoStopAfter = int.parse(controller.text);
        });
      }
    }

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
                          hour: widget.alarm.hour, minute: widget.alarm.minute),
                  initialEntryMode: TimePickerEntryMode.dial,
                  builder: (context, child) {
                    return MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(alwaysUse24HourFormat: false),
                        child: child!);
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
                style: TextStyle(fontSize: 46),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Repetir',
              style: TextStyle(fontSize: 18),
            ),
            Wrap(
                spacing: 2,
                children: daysConfig.map((day) {
                  final int value = day['value'];
                  final String label = day['label'];
                  final bool isSelected = selectedDays.contains(value);

                  return FilterChip(
                    label: Text(label),
                    showCheckmark: false,
                    selected: isSelected,
                    selectedColor: Colors.purple.shade300,
                    onSelected: (_) => toggleDay(value),
                  );
                }).toList()),
            SizedBox(
              height: 16,
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
                Spacer(),
                SizedBox(
                  height: 42,
                  width: 60,
                  child: InputField(
                    widget: widget,
                    controller: snoozeCtrller,
                    indicator: 'snooze',
                    alarmTime: widget.alarm.snoozeMinutes,
                    time: snoozeMinutes,
                    setTime: setNewSnoozeNStopTime,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Text('Desactivar despues de: '),
                Spacer(),
                Switch(
                  value: autoStop,
                  onChanged: (value) {
                    setState(() {
                      autoStop = !autoStop;
                    });
                  },
                )
              ],
            ),
            // linea de ejemplo, para ingreso de timepo
            Row(
              children: [
                Text('Minutos'),
                Spacer(),
                autoStop
                    ? SizedBox(
                        height: 42,
                        width: 60,
                        child: InputField(
                          controller: stopCtrller,
                          widget: widget,
                          indicator: 'autoStop',
                          time: autoStopAfter,
                          alarmTime: widget.alarm.autoStopAfterMinutes,
                          setTime: setNewSnoozeNStopTime,
                        ))
                    : SizedBox(
                        width: 60,
                        child: Text(
                          autoStopAfter.toString(),
                          textAlign: TextAlign.center,
                        ),
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          label: Text('Accept'),
          onPressed: () => acceptAlarm(),
          icon: Icon(Icons.add_alarm)),
    );
  }
}

class InputField extends StatelessWidget {
  // controllador
  final TextEditingController controller;
  // widgerRef
  final AlarmWidget widget;
  // valor int del objeto Alarm
  final int alarmTime;
  // variable de tiempo this snooze or stopAfter
  final int time;
  // indicador de valor a modificar
  final String indicator;
  final void Function(String value, int time, int alarmTime,
      TextEditingController controller, String indicator) setTime;

  const InputField(
      {super.key,
      required this.controller,
      required this.widget,
      required this.time,
      required this.alarmTime,
      required this.setTime,
      required this.indicator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical(y: 1),
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(),
      onChanged: (value) =>
          setTime(value, time, alarmTime, controller, indicator),
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          hintText: alarmTime.toString()),
    );
  }
}
