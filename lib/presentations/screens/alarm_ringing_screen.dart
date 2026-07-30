import 'dart:async';
import 'dart:math';
import 'package:alarm_play/infrastructure/navigation/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:isar/isar.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:alarm_play/infrastructure/controllers/alarm_controller_provider.dart';
import 'package:alarm_play/infrastructure/db/isar_service.dart';
import 'package:alarm_play/infrastructure/services/obtain_12hours_service.dart';
import 'package:alarm_play/data/entities/alarm_entity.dart';

import '../../infrastructure/providers/providers.dart';
import 'screens.dart';

class AlarmRingingScreen extends ConsumerStatefulWidget {
  final Id alarmId;
  const AlarmRingingScreen({super.key, required this.alarmId});

  @override
  ConsumerState<AlarmRingingScreen> createState() => _AlarmRingingScreenState();
}

class _AlarmRingingScreenState extends ConsumerState<AlarmRingingScreen>
    with SingleTickerProviderStateMixin {
  static const channel = MethodChannel("alarm_play/alarm_receiver");
  final isar = IsarService.instance;
  int silenciar = 10;
  bool _mostrarContador = false;
  late int time;
  Color backgrounColor = Colors.red.shade200;
  bool isProcessingEnd = false;
  Timer? _timer;
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
    getSnoozeTime();
    time = 7;
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    _startAlarm();
    _countdownStop();
    startLoop();
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    _controller.removeStatusListener(_animationStatusListener);
    _controller.dispose();
    _timer?.cancel();
    time = 7;
    super.dispose();
  }

// metodo inicia la alarma, sonido, vibracion, sonido ascedente
  Future<void> _startAlarm() async {
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

// metodo detiene las animaciones del los metodos hold para silenciar alarm
  void _countdownStop() {
    setState(() {
      _mostrarContador = false;
      _controller.reset();
      time = 7;
    });
  }

// metodo inicia las animaciones de los metodos hold para silenciar alarm
  void _countdownStart() {
    setState(() {
      _mostrarContador = true;
      _controller.forward();
    });
  }

// metodo se llama cuando terminan las animaciones de los metodos hold para silenciar alarm, detiene todos los controlladores y agenda una alarma dentro de los minutos seleccinados sin guardar en DB
  Future<void> _countdownEnd() async {
    if (isProcessingEnd || !mounted) return;
    isProcessingEnd = true;
    _controller.removeStatusListener(_animationStatusListener);
    _countdownStop();
    _timer?.cancel();
    try {
      final Alarm? alarm = await isar.alarms.get(widget.alarmId);
      final controller = ref.read(alarmControllerProvider);
      if (!mounted) return;
      await ref.read(audioServiceProvider).stop();
      await ref.read(vibrationServiceProvider).stop();
      if (alarm == null) return;
      await controller.stopAlarm(alarm);
      try {
        await channel.invokeMethod('clearPendingAlarm');
      } catch (e) {
        print('Error while cleaning pending alarm $e');
      }
      await controller.scheduleSnoozeAlarm(alarm, alarm.snoozeMinutes);
      // setState(() {});
      if (mounted) {
        navigatorKey.currentState?.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
            (route) => false);
      }
    } catch (e) {
      print('Error miestras se ejecuta el snooze $e');
      isProcessingEnd = false;
    }
  }

// metodo detiene las alarmas, sonido, vibraciones etc
  Future<void> _stopAlarm() async {
    _timer?.cancel();
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
      navigatorKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
          (route) => false);
    }
  }

// metodo retorna la hora actual, se ejecuta por streambuilder
  TimeOfDay syncTime() {
    final TimeOfDay now = TimeOfDay.now();
    return now;
  }

// listener del status de animaciones para los metodos hold para silenciar alarmas
  void _animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _countdownEnd();
    }
  }

// metodo cambia el valor del coundown indicator, esto nos cambia el UI, asi el usuario tiene un apoyo visual
  int countdownIndicator() {
    time--;
    return time;
  }

// este metodo cambia el color del fondo de pantalla,
  void startLoop() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(milliseconds: 210), (timer) {
      backgrounColor = getBackgroundColor();
      setState(() {});
    });
  }

// metodo retorna un color, para cambiar el color de fondo de pantalla de acuerdo a la lista
  Color getBackgroundColor() {
    List<Color> colors = [
      Colors.amber,
      Colors.red.shade200,
      Colors.blue,
      Colors.purpleAccent,
      Colors.greenAccent
    ];
    Random random = Random();
    return colors[random.nextInt(colors.length)];
  }

// metodo actualiza el UI, el valor del snooze time, de acuerdo a la alarma actual
  Future<void> getSnoozeTime() async {
    final Alarm? alarm = await isar.alarms.get(widget.alarmId);
    silenciar = alarm!.snoozeMinutes;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _controller.addStatusListener(_animationStatusListener);
    return Scaffold(
        // pasamos el background de manera dinamica
        backgroundColor: backgrounColor,
        body: GestureDetector(
            onVerticalDragUpdate: (details) {
              _stopAlarm();
              // detenemos la alarma al deslizar sobre la pantalla
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
                  Center(
                    child: Column(children: [
                      if (_mostrarContador)
                        Column(children: [
                          StreamBuilder(
                              stream:
                                  // este stream nos cambia el contador miestrar mantenemos precionado el boton, silenciar alarm
                                  Stream.periodic(Duration(milliseconds: 520)),
                              builder: (context, snapshot) {
                                final text = countdownIndicator();
                                print(text);
                                return Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white10,
                                      borderRadius: BorderRadius.circular(12)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Manten presionado'),
                                      Text(
                                        text.toString(),
                                        style: TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight(600)),
                                      ),
                                      SizedBox(
                                          width: 98,
                                          child: LinearProgressIndicator(
                                            controller: _controller,
                                            backgroundColor:
                                                Colors.grey.shade300,
                                          )),
                                    ],
                                  ),
                                );
                              }),
                        ]),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Desliza para detener',
                        style: TextStyle(fontSize: 22),
                      ),
                    ]),
                  )
                ],
              ),
            )),
        // boton para silenciar alarma, tenemos una dinamica de hold durante un tiempo para ejecutar el codigo, si se levanta la precion antes de finalizar el tiempo se reinicia.
        floatingActionButton: GestureDetector(
            onTapDown: (_) => _countdownStart(),
            onTapUp: (_) => _countdownStop(),
            onTapCancel: () => _countdownStop(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple.shade300,
                  ),
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
