import 'package:alarm_play/core/providers/playlist_list_provider.dart';
import 'package:alarm_play/core/providers/playlist_repository_provider.dart';
import 'package:alarm_play/presentations/screens/playlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/controllers/controllers.dart';
import '../../core/services/services.dart';
import '../../data/entities/entities.dart';

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
      defaultSound: 'assets/audiofiles/alarm.mp3',
      playlistId: 0,
      playbackMode: PlaybackMode.sequential,
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
      // siempre se envia una alarma, newAlarm la default para crear nueva, y widget.alarm para editar
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
  late bool vibrar;
  late bool playOnce;
  late bool autoStop;
  late bool ascendingVolume;
  late int snoozeMinutes;
  late int autoStopAfter;
  late PlaybackMode playBackMode;
  late double volume;
  late List<int> selectedDays;
  late int playListId;
  bool shufleSound = false;
  // DateTime? nexTrigger = widget.alarm.nextTrigger;
  final TextEditingController snoozeCtrller = TextEditingController();
  final TextEditingController stopCtrller = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedDays = widget.alarm.repeatDays;
    vibrar = widget.alarm.vibrateEnabled;
    playOnce = widget.alarm.playOnce;
    autoStop = widget.alarm.autoStop;
    ascendingVolume = widget.alarm.ascendingVolume;
    snoozeMinutes = widget.alarm.snoozeMinutes;
    autoStopAfter = widget.alarm.autoStopAfterMinutes;
    playBackMode = widget.alarm.playbackMode;
    volume = widget.alarm.volume;
    playListId = widget.alarm.playlistId;
    syncPlayBackMode();
  }

  void syncPlayBackMode() {
    if (widget.alarm.playbackMode == PlaybackMode.shuffle) {
      shufleSound = true;
    } else {
      shufleSound = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // todo con mismo sistema puedo modificar el UI para visualizar los dias mejor
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
      widget.alarm.hour = selectedTime!.hour;
      widget.alarm.minute = selectedTime!.minute;
      widget.alarm.ascendingVolume = ascendingVolume;
      widget.alarm.playlistId = playListId;
      widget.alarm.id = widget.alarm.id;
      widget.alarm.autoStop = autoStop;
      widget.alarm.autoStopAfterMinutes = autoStopAfter;
      widget.alarm.isActive = true;
      widget.alarm.playOnce = playOnce;
      widget.alarm.playbackMode = playBackMode;
      widget.alarm.repeatDays = selectedDays;
      widget.alarm.snoozeMinutes = snoozeMinutes;
      widget.alarm.vibrateEnabled = vibrar;
      widget.alarm.volume = volume;

      ref.read(alarmControllerProvider).createAlarm(widget.alarm);
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

    final playListStream = ref.watch(playlistListProvider);
    bool existPlaylist = false;

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
              children: [
                playListStream.when(
                    data: (playlist) {
                      if (playlist.isEmpty) {
                        existPlaylist = true;
                        return Text('Aun no tienes playlist creadas');
                      }
                      return DropdownMenu(
                          initialSelection: playListId,
                          onSelected: (value) {
                            setState(() {
                              playListId = value!.toInt();
                            });
                          },
                          dropdownMenuEntries: playlist.map((item) {
                            return DropdownMenuEntry(
                                value: item.id, label: item.name);
                          }).toList());
                    },
                    error: (e, _) {
                      return Center(
                        child: Text(
                            'Error during listen the stream: ${e.toString()}'),
                      );
                    },
                    loading: () => Text('Cargando playLists')),
                Spacer(),
                existPlaylist
                    // aca se separo el boton para ir a crear o editar playList. Para poder crear nuevas aunque ya exista alguna
                    ? SizedBox()
                    : IconButton(
                        onPressed: () async {
                          final playList = await ref
                              .read(playlistRepositoryProvider)
                              .getById(playListId);
                          if (mounted) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  PlaylistCreateScreen(playList: playList),
                            ));
                          }
                        },
                        icon: Text('Edit')),
                SizedBox(
                  width: 6,
                ),
                IconButton(
                    onPressed: () async {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PlaylistCreateScreen(),
                      ));
                    },
                    // necesito metodo para crear una nueva, aunque ya exista alguna anterior
                    icon: Text('New +'))
              ],
            ),
            Row(
              children: [
                Text('Orden de reproduccion aleatorio'),
                Spacer(),
                Switch(
                  value: shufleSound,
                  onChanged: (value) {
                    setState(() {
                      shufleSound = !shufleSound;
                      if (shufleSound) {
                        playBackMode = PlaybackMode.shuffle;
                      } else {
                        playBackMode = PlaybackMode.sequential;
                      }
                    });
                  },
                )
              ],
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
                Text('Volumen ascendente'),
                Spacer(),
                Switch(
                  value: ascendingVolume,
                  onChanged: (value) {
                    setState(() {
                      ascendingVolume = !ascendingVolume;
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
            // todo me falta elegir el playbackmode
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
