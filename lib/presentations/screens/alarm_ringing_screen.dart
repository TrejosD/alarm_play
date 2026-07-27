import 'dart:async';
import 'package:alarm_play/presentations/screens/home_screen.dart';
import 'package:flutter/services.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:isar/isar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:alarm_play/infrastructure/controllers/alarm_controller_provider.dart';
import 'package:alarm_play/infrastructure/db/isar_service.dart';
import 'package:alarm_play/infrastructure/services/obtain_12hours_service.dart';
import 'package:alarm_play/data/entities/alarm_entity.dart';

import '../../infrastructure/providers/providers.dart';

class AlarmRingingScreen extends ConsumerStatefulWidget {
  final Id alarmId;
  const AlarmRingingScreen({super.key, required this.alarmId});

  @override
  ConsumerState<AlarmRingingScreen> createState() => _AlarmRingingScreenState();
}

class _AlarmRingingScreenState extends ConsumerState<AlarmRingingScreen>
    with SingleTickerProviderStateMixin {
  static const channel = MethodChannel("alarm_play/alarm_receiver");
  int silenciar = 10;
  bool _mostrarContador = false;
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
    getSnoozeTime();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    _startAlarm();
    _countdownStop();
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    super.dispose();
  }

  Future<void> _startAlarm() async {
    // ref.read(alarmExecutedProvider.notifier).state = true;
    final isar = IsarService.instance;
    Alarm? alarm = await isar.alarms.get(widget.alarmId);
    if (alarm == null) return;
    double initialVolume = 0.1;
    if (!alarm.ascendingVolume) {
      initialVolume = 1.0;
    }
    final audio = ref.read(audioServiceProvider);
    if (alarm.vibrateEnabled) {
      await ref.read(vibrationServiceProvider).start();
    }
    await audio.startAlarm(
        playlistId: alarm.playlistId,
        mode: alarm.playbackMode,
        volume: alarm.volume,
        initialVolume: initialVolume);
    setState(() {});
  }

  void _countdownStop() {
    setState(() {
      _mostrarContador = false;
      _controller.reset();
    });
  }

  void _countdownStart() {
    setState(() {
      _mostrarContador = true;
      _controller.forward();
    });
  }

  Future<void> _countdownEnd() async {
    _countdownStop();
    final isar = IsarService.instance;
    final Alarm? alarm = await isar.alarms.get(widget.alarmId);
    final controller = ref.read(alarmControllerProvider);
    await ref.read(audioServiceProvider).stop();
    await ref.read(vibrationServiceProvider).stop();
    if (alarm == null) return;
    await controller.stopAlarm(alarm);
    ref
        .read(alarmControllerProvider)
        .scheduleSnoozeAlarm(alarm, alarm.snoozeMinutes);
    setState(() {});
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false);
    }
  }

  Future<void> _stopAlarm() async {
    final isar = IsarService.instance;
    Alarm? alarm = await isar.alarms.get(widget.alarmId);
    final controller = ref.read(alarmControllerProvider);
    await ref.read(audioServiceProvider).stop();
    await ref.read(vibrationServiceProvider).stop();
    if (alarm == null) return;
    await controller.stopAlarm(alarm);
    try {
      await channel.invokeMethod('clearPendingAlarm');
    } catch (e) {
      print('Error limpiando alarm nativa: $e');
    }
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
          (route) => false);
    }
  }

  TimeOfDay syncTime() {
    final TimeOfDay now = TimeOfDay.now();
    return now;
  }

  Future<void> getSnoozeTime() async {
    final isar = IsarService.instance;
    final Alarm? alarm = await isar.alarms.get(widget.alarmId);
    silenciar = alarm!.snoozeMinutes;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _countdownEnd();
      }
    });
    return Scaffold(
        body: GestureDetector(
            onVerticalDragUpdate: (details) {
              _stopAlarm();
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              height: 800,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      // este streambuilder actualiza la hora actual cada 30s, para mostrar siempre la hora actual en alerta
                      child: StreamBuilder(
                    stream: Stream.periodic(Duration(seconds: 30)),
                    builder: (context, snapshot) {
                      return Text(
                        Obtain12hoursService.obtenerFormatoAmPm(syncTime()),
                        style: TextStyle(fontSize: 58),
                      );
                    },
                  )),
                  SizedBox(
                    height: 28,
                  ),
                  Text('Desliza para detener')
                ],
              ),
            )),
        floatingActionButton: GestureDetector(
            onTapDown: (_) => _countdownStart(),
            onTapUp: (_) => _countdownStop(),
            onTapCancel: () => _countdownStop(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (_mostrarContador)
                  SizedBox(
                      width: 98,
                      child: LinearProgressIndicator(
                        controller: _controller,
                        backgroundColor: Colors.grey.shade300,
                      )),
                SizedBox(
                  height: 8,
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  label: Text('Silenciar por: $silenciar'),
                ),
                SizedBox(
                  height: 12,
                )
              ],
            )));
  }
}

/*Necesito:
un reloj con la hra actual en grande.
metodo detener alarma deslisando sobre la pantalla.
  acompañar un texto explicando como detener la alarma
boton para pausar la alarma, metodo on longpress pausa la alarma el tiempo se que haya seteado previamente
 */
