import 'package:flutter_riverpod/flutter_riverpod.dart';

// ese mapa contiene los dias y un valor numerico para mostrar en UI, los dias de repeticion de un alarma
final dayRepeatMapProvider = Provider<List<Map<String, dynamic>>>(
  (ref) {
    final List<Map<String, dynamic>> daysConfig = [
      {'label': 'L', 'value': 1},
      {'label': 'M', 'value': 2},
      {'label': 'K', 'value': 3},
      {'label': 'J', 'value': 4},
      {'label': 'V', 'value': 5},
      {'label': 'S', 'value': 6},
      {'label': 'D', 'value': 7},
    ];

    return daysConfig;
  },
);
