import 'package:alarm_play/core/controllers/alarm_controller_provider.dart';
import 'package:alarm_play/core/db/isar_service.dart';
import 'package:alarm_play/core/providers/audio_service_provider.dart';
import 'package:alarm_play/core/providers/vibration_service_provider.dart';
import 'package:alarm_play/core/services/obtain_12hours_service.dart';
import 'package:alarm_play/data/entities/alarm_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:isar/isar.dart';

class AlarmRingingScreen extends ConsumerStatefulWidget {
  final Id alarmId;
  const AlarmRingingScreen({super.key, required this.alarmId});

  @override
  ConsumerState<AlarmRingingScreen> createState() => _AlarmRingingScreenState();
}

class _AlarmRingingScreenState extends ConsumerState<AlarmRingingScreen> {
  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
    _startAlarm();
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    super.dispose();
  }

  Future<void> _startAlarm() async {
    final isar = IsarService.instance;
    Alarm? alarm = await isar.alarms.get(widget.alarmId);
    if (alarm == null) return;
    final audio = ref.read(audioServiceProvider);
    if (alarm.vibrateEnabled) {
      await ref.read(vibrationServiceProvider).start();
    }
    await audio.startAlarm(
        assetPath: 'assets/audiofiles/alarm.mp3', volume: alarm.volume);
    setState(() {});
  }

  Future<void> _stopAlarm() async {
    final isar = IsarService.instance;
    Alarm? alarm = await isar.alarms.get(widget.alarmId);
    final controller = ref.read(alarmControllerProvider);
    await ref.read(audioServiceProvider).stop();
    await ref.read(vibrationServiceProvider).stop();
    if (alarm!.playOnce) {
      await controller.deleteAlarm(alarm.id);
    } else {
      await controller.onAlarmTriggered(alarm.id);
    }
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final TimeOfDay hora = TimeOfDay.now();
    final int silenciar = 10;
    return GestureDetector(
      onVerticalDragDown: (details) {
        _stopAlarm();
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                Obtain12hoursService.obtenerFormatoAmPm(hora),
                style: TextStyle(fontSize: 58),
              ),
              // todo aca tengo la hora actual en 24H, necesito como convertir la hora en 12H
            ),
            SizedBox(
              height: 28,
            ),
            Text('Desliza para detener')
          ],
        ),
        floatingActionButton: ElevatedButton.icon(
          onPressed: () {},
          label: Text('Silenciar por: $silenciar'),
          onLongPress: () {
            // todo Provider para la cantidad de tiempo de silencio en settings
            // todo medoto para selenciar alarma.
          },
        ),
      ),
    );
  }
}

/*Necesito:
un reloj con la hra actual en grande.
metodo detener alarma deslisando sobre la pantalla.
  acompañar un texto explicando como detener la alarma
boton para pausar la alarma, metodo on longpress pausa la alarma el tiempo se que haya seteado previamente
 */

// todo necesito aca, los metodos play() para reproducir el sonido
