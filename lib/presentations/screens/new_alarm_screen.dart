import 'package:alarm_play/data/entities/alarm_entity.dart';
import 'package:flutter/material.dart';

class NewAlarmScreen extends StatefulWidget {
  final Alarm? alarm;
  const NewAlarmScreen({super.key, this.alarm});

  @override
  State<NewAlarmScreen> createState() => _NewAlarmScreenState();
}

class _NewAlarmScreenState extends State<NewAlarmScreen> {
  TimeOfDay? selectedTime;
  bool vibrar = true;
  bool playOnce = false;
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
              onPressed: () {
                // todo metod crear ACCEPT alarma
              },
              icon: Icon(Icons.check_rounded))
        ],
        title:
            widget.alarm != null ? Text('Editar alarma') : Text('Crear alarma'),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () async {
              final TimeOfDay? time = await showTimePicker(
                context: context,
                initialTime: selectedTime ?? TimeOfDay.now(),
                initialEntryMode: TimePickerEntryMode.input,
                builder: (context, child) {
                  return child!;
                },
              );
              setState(() {
                selectedTime = time;
              });
            },
            child: Text('${selectedTime ?? TimeOfDay.now()}'),
            // todo crear human time layout
          ),
          Row(
            children: [
              Text('Vibrar al sonar'),
              Switch(
                value: vibrar,
                onChanged: (value) {
                  // todo metodo switch para activar y desactivar la vibracion
                },
              )
            ],
          ),
          Row(
            children: [
              Text('Eliminar despues de sonar'),
              Switch(
                value: playOnce,
                onChanged: (value) {
                  // todo metodo switch para activar y desactivar la alarma se elimine automaticamente
                },
              )
            ],
          )
          // forma de seleccionar hora DONE
          // playList selector
          // repetir
          // vibrar al sonar SWITCH default true Done
          // eliminar despues de sonar SWITCH default false DONE
        ],
      ),
    );
  }
}
