import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  }

  @override
  void dispose() {
    WakelockPlus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final int silenciar = 10;
    return Scaffold(
      body: Row(
        children: [
          Center(
            child: Text('${now.hour} : ${now.minute}'),
            // todo aca tengo la hora actual en 24H, necesito como convertir la hora en 12H
          ),
          Text('Desliza para detener')
        ],
      ),
      floatingActionButton: IconButton(
        onPressed: () {},
        icon: Text('Silenciar por: $silenciar'),
        onLongPress: () {
          // todo Provider para la cantidad de tiempo de silencio en settings
          // todo medoto para selenciar alarma.
        },
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
