import 'package:flutter/material.dart';

class AlarmCard extends StatelessWidget {
  const AlarmCard({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isActived = false;
    // todo crear el getter para esta variable y metodo
    return Card(
      elevation: 8,
      child: Column(
        children: [
          Row(
            children: [
              Text('06:00 am'),
              Switch(value: isActived, onChanged: null),
            ],
          ),
          Row(children: [Text('Repeticion'), Text('Sonara dentro de XXX')]),
          Text('Song / PlayList Name'),
        ],
      ),
    );
  }
}
