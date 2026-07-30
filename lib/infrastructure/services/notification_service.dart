import 'dart:io';

import 'package:alarm_play/presentations/widgets/xiaomi_permission_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

// este servicio nos permte manejar las notificaciones
class NotificationService {
  final FlutterLocalNotificationsPlugin plugin;
  static const _channel = MethodChannel('alarm_play/xiaomi');
  static const String xiaomiPermissionKey = 'xiaomi_permissions_configured';

  NotificationService(this.plugin);

  Future<void> init({
    required Function(int alarmId) onAlarmTriggered,
  }) async {
    const androidSettings = AndroidInitializationSettings('app_icon');

    const settings = InitializationSettings(android: androidSettings);

    await plugin.initialize(
        settings: settings,
        onDidReceiveNotificationResponse: (response) {
          final payload = response.payload;
          if (payload == null) return;
          final alarmId = int.parse(payload);
          onAlarmTriggered(alarmId);
        });
  }

// metodo revisa si tenemos permiso para recibir notificationes
  Future<void> checkExactAlarmPermission(BuildContext context) async {
    if (!Platform.isAndroid) return;
    var status = await Permission.scheduleExactAlarm.status;
    if (status.isDenied) {
      await Permission.scheduleExactAlarm.request();
    }

    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    final manufacturer = androidInfo.manufacturer.toLowerCase();
    bool isXiaomi = manufacturer.toLowerCase().contains('xiaomi') ||
        manufacturer.toLowerCase().contains('poco') ||
        manufacturer.toLowerCase().contains('redmi');
    if (isXiaomi) {
      final prefs = await SharedPreferences.getInstance();
      // si ya fue configurado terminamos
      bool alreadyConfigurated = prefs.getBool(xiaomiPermissionKey) ?? false;
      if (alreadyConfigurated) return;
      // si no se a configurafo mostramos el dialogo
      if (context.mounted) {
        XioamiPermissionUserHandler.showXiaomiPermissionDialog(context, prefs);
      }
    }
  }

// metodo revisa los permisos necesarios para el app, en dispositivos Xiaomi
  Future<void> checkXiaomiPermissions() async {
    try {
      await _channel.invokeMethod('xiaomiPermissionRequest');
    } on PlatformException catch (e) {
      print("Error en el canal nativo Xiaomi: ${e.message}");
    }
  }
}
