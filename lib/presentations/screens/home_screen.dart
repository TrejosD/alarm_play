import 'package:alarm_play/presentations/widgets/alarm_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          // todo este item builder crea la X cantidad de cards de acuerdo a alarmas tiene almacenadas
          return AlarmCard();
        },
      ),
    );
  }
}
