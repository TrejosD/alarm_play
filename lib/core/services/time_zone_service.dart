import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone_latest/flutter_native_timezone_latest.dart';

class TimeZoneService {
  static Future<void> init() async {
    tz.initializeTimeZones();

    final String timezone =
        await FlutterNativeTimezoneLatest.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timezone));
  }
}
