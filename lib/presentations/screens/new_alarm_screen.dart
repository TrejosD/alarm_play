import 'package:alarm_play/presentations/providers/days_repeat_map_provider.dart';
import 'package:alarm_play/presentations/widgets/delete_playlist_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../infrastructure/controllers/controllers.dart';
import '../../infrastructure/providers/providers.dart';
import '../../infrastructure/services/services.dart';
import '../../data/entities/entities.dart';
import 'screens.dart';

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
  final TextEditingController snoozeCtrller = TextEditingController();
  final TextEditingController stopCtrller = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedDays = [];
    introduceSelectedDays();
    selectedTime =
        TimeOfDay(hour: widget.alarm.hour, minute: widget.alarm.minute);
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

// con este metodo actualizamos el switch shuffleSound de acuerdo a la Alarm recivida
  void syncPlayBackMode() {
    if (widget.alarm.playbackMode == PlaybackMode.shuffle) {
      shufleSound = true;
    } else {
      shufleSound = false;
    }
  }

  void introduceSelectedDays() {
    final days = widget.alarm.repeatDays;
    for (final day in days) {
      selectedDays.add(day);
    }
  }

  @override
  Widget build(BuildContext context) {
    // mapa de dias vs daysInt para visualizar el UI
    final daysConfig = ref.read(dayRepeatMapProvider);
// selecciona o retira seleccion de dias a repetir
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

// metodo para los valores al Alarm y la crea o edita
    void acceptAlarm() {
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

// metodo cambia el tiempo que el usuario desea sileciar su alarma, si no, mantiene el default
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

// stream que muestra todas las playlist creadas
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
                // timepicker para seleccionar la hora de la alarma
                final TimeOfDay? time = await showTimePicker(
                  context: context,
                  initialTime: selectedTime!,
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
              // aca usamos el servicio para cambiar la hora de 24h a 12h
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
            // mapa de objetos seleccionador de dias a repetir
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
                        existPlaylist = false;
                        return Text('Aun no tienes playlist creadas');
                      }
                      existPlaylist = true;
                      return DropdownMenu(
                          initialSelection: playListId,
                          onSelected: (value) {
                            setState(() {
                              playListId = value!.toInt();
                            });
                          },
                          dropdownMenuEntries: playlist.map((item) {
                            return DropdownMenuEntry(
                                trailingIcon: IconButton(
                                  onPressed: () => showDialog(
                                      context: context,
                                      builder: (context) =>
                                          DeletePlaylistDialog(playlist: item)),
                                  icon: Icon(Icons.delete_forever_outlined),
                                ),
                                // el laelWidget requiere un widget, por lo que lo utilizamos para tener el longPress que necesito para el metodo de eliminar playlist
                                labelWidget: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 2),
                                    child: Text(item.name!)),
                                value: item.id,
                                label: item.name!);
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
                    ? IconButton.outlined(
                        style: IconButton.styleFrom(
                            side: BorderSide(
                                color: const Color.fromARGB(255, 70, 7, 82),
                                width: 1.5)),
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
                        icon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            'Edit',
                          ),
                        ))
                    : SizedBox(),
                SizedBox(
                  width: 6,
                ),
                IconButton.filled(
                    onPressed: () async {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PlaylistCreateScreen(),
                      ));
                    },
                    // necesito metodo para crear una nueva, aunque ya exista alguna anterior
                    icon: Text(
                      'New +',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ))
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
                      // cambiamos el PlaybackMode de shuffle a sequetial o al reves
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

// este inputField, nos permite tener varios input iguales en el UI
class InputField extends StatelessWidget {
  // controllador
  final TextEditingController controller;
  // widgetRef
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
