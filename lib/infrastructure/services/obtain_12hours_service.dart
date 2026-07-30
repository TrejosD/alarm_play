import 'package:flutter/material.dart';

// este servicio nos permite convertir horas formato 24h a 12h
class Obtain12hoursService {
  static String obtenerFormatoAmPm(TimeOfDay time) {
    final int horaFormateada = time.hour > 12 ? time.hour - 12 : time.hour;
    // Manejo especial si la hora es 0 (las 12:00 AM)
    final int horaFinal = horaFormateada == 0 ? 12 : horaFormateada;
    final String periodo = time.hour >= 12 ? 'PM' : 'AM';
    final String minuto = time.minute.toString().padLeft(2, '0');

    return '$horaFinal:$minuto $periodo'; // Ejemplo: 5:30 PM
  }
}
