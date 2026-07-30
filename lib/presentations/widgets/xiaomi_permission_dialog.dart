import 'package:alarm_play/infrastructure/services/notification_service.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

// este widget se muestra en dispositivos Xiaomi, para verificar los permisos necesarios para el correcto funcionamiento del app
class XioamiPermissionUserHandler {
  static void showXiaomiPermissionDialog(
      BuildContext context, SharedPreferences prefs) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Colors.orange,
                size: 28,
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text(
                  'Ajuste de Xiaomi Requerido',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  'Para que tu alarma suene y despierte la pantalla correctamente, tu telefono xiaomi requiere permisos especiales.',
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'En la siguiente pantalla, ve a "Otros permisos" y activa obligatoriamente:',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.blueGrey),
                ),
                SizedBox(
                  height: 10,
                ),
                _PermissionBulletItem(text: 'Mostrar en pantalla de bloqueo'),
                _PermissionBulletItem(
                    text:
                        'Mostrar ventanas emergentes mientras se ejecuta en segundo plano'),
                _PermissionBulletItem(text: 'Mostrar ventanas emergentes'),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  // si cancela se ejecuta de nuevo al abrir el app
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Más tarde',
                  style: TextStyle(color: Colors.blueGrey),
                )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(16))),
                onPressed: () async {
                  // guardamos para no mostrar de nuevo el dialogo
                  await prefs.setBool(
                      NotificationService.xiaomiPermissionKey, true);
                  if (context.mounted) Navigator.of(context).pop();
                  await openXiaomiPermissionsScreen();
                },
                child: Text(
                  'Configurar Ahora',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        );
      },
    );
  }

  static Future<void> openXiaomiPermissionsScreen() async {
    try {
      // intento para abrir ventana de "Otros permisos"
      final AndroidIntent intent = AndroidIntent(
        action: 'miui.intent.action.APP_PERM_EDITOR',
        arguments: <String, dynamic>{
          // Pasa el paquete del app, para que se abra directamente en nuestra app
          'extra_pkgname': 'com.example.alarm_play'
        },
      );
      await intent.launch();
    } catch (e) {
      // si no fuera posible abrir la ventana de otros permisos, abrirmos la ventana de Apps Settings
      print("Error abriendo pantalla especifica Xiaomi, usando fallback $e");
      await openAppSettings();
    }
  }
}

class _PermissionBulletItem extends StatelessWidget {
  final String text;
  const _PermissionBulletItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Expanded(
              child: Text(
            text,
            style: TextStyle(fontSize: 14),
          ))
        ],
      ),
    );
  }
}
