import 'package:flutter_riverpod/flutter_riverpod.dart';

// este provider nos informa si el alarma ya fue ejecutada
final alarmExecutedProvider = StateProvider<bool>((ref) => false);
