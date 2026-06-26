import 'package:alarm_play/core/providers/alarm_provider.dart';
import 'package:alarm_play/core/services/notification_service.dart';
import 'package:alarm_play/presentations/screens/new_alarm_screen.dart';
import 'package:alarm_play/presentations/widgets/alarm_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final notifications = FlutterLocalNotificationsPlugin();
    final notificationService = NotificationService(notifications);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await notificationService.checkExactAlarmPermission(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final alarmAsync = ref.watch(alarmsProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Alarm Play')),
      body: alarmAsync.when(
          data: (alarms) {
            if (alarms.isEmpty) {
              return Center(
                child: Text('No alarms'),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: alarms.length,
                itemBuilder: (context, index) {
                  final thisAlarm = alarms[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => NewAlarmScreen(
                          alarm: thisAlarm,
                        ),
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Container(
                        decoration: BoxDecoration(
                          color: thisAlarm.playOnce
                              ? Colors.red.shade200
                              : Colors.black12,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: AlarmCard(
                          alarm: thisAlarm,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
          error: (e, _) => Center(
                child: Text('Error ${e.toString()}'),
              ),
          loading: () => Center(child: CircularProgressIndicator())),
      // Probar Notificationes Local
      // floatingActionButton: FloatingActionButton(
      //     onPressed: () async {
      //       await AlarmBridgeService.scheduleAlarm(
      //           alarmId: 1,
      //           triggerTime: DateTime.now().add(Duration(seconds: 15)));
      //     },
      //     child: Text('trigger Alarm')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NewAlarmScreen(),
          ));
        },
        child: Icon(Icons.add_alarm_rounded),
      ),
    );
  }
}
