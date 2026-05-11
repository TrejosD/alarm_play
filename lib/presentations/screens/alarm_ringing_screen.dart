import 'package:alarm_play/data/entities/entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlarmRingingScreen extends ConsumerWidget {
  final Alarm alarm;
  const AlarmRingingScreen({super.key, required this.alarm});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final int silenciar = 10;
    return Scaffold(
      body: Center(
        child: Text('${now.hour} : ${now.minute}'),
        // todo aca tengo la hora actual en 24H, necesito como convertir la hora en 12H
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
