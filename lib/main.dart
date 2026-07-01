import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'core/services/services.dart';
import 'package:alarm_play/core/navigation/app_router.dart';
import 'package:alarm_play/core/db/isar_service.dart';
import 'presentations/screens/screens.dart';

void main() async {
  Future<void> initAppDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    // metodo inicia el TImeZoneService
    await TimeZoneService.init();
    // metodo inicia el ISarService
    await IsarService.init();
    // Metodo inicia el JustAudio para sonido en background
    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.example.alarm_play',
      androidNotificationChannelName: 'alarm_audio',
      androidNotificationOngoing: true,
    );
  }

  @pragma('vm:entry-point')
  void restoreAlarmsEntryPoint() async {
    await initAppDB();
    // todo probar creando una alarma a una hora X e ingresandola a la DB, para ver si este codigo se esta ejecutando
    final isar = IsarService.instance;
    final alarmScheduler = AlarmSchedulerService();
    final restoreService =
        AlarmRestoreService(isar: isar, alarmScheduler: alarmScheduler);
    try {
      print('Restore Service Execution');
      restoreService.restoreAllActiveAlarms();
    } catch (e) {
      print('Error desde restoreAllActiveAlarms: $e');
    }
  }

  await initAppDB();
// este no lo veo funcionar para nada
  // final notifications = FlutterLocalNotificationsPlugin();
  // final notificationService = NotificationService(notifications);
  // await notificationService.init(onAlarmTriggered: (alarmId) {
  //   navigatorKey.currentState?.push(MaterialPageRoute(
  //       builder: (_) => AlarmRingingScreen(alarmId: alarmId)));
  // });
  // todo de estos 3 metodos para la navegacion, ELIMINAR los que no sean necesarios
  // final notificationDetails =
  //     await notifications.getNotificationAppLaunchDetails();
  // if (notificationDetails?.didNotificationLaunchApp ?? false) {
  //   final payload = notificationDetails!.notificationResponse?.payload;
  //   if (payload != null) {
  //     final alarmId = int.parse(payload);
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       navigatorKey.currentState?.push(MaterialPageRoute(
  //         builder: (context) => AlarmRingingScreen(alarmId: alarmId),
  //       ));
  //     });
  //   }
  // }
  // esto me muestra las notificationes pendientes, "que no fueron mostradas y quedaron pegadas"
  // final pending = await notifications.pendingNotificationRequests();
  // for (final notification in pending) {
  //   print('Pending Notification ${notification.id}');
  //   print('Notification info: ${notification.body}');
  // }

// Listener que al escuchar una alarma ejecuta la navegacion
  final alarmEventService = AlarmEventService();
  alarmEventService.alarmStream.listen((alarmId) {
    navigatorKey.currentState?.push(MaterialPageRoute(
      builder: (context) => AlarmRingingScreen(alarmId: alarmId),
    ));
  });
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomeScreen(),
    );
  }
}
