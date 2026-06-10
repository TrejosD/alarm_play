import 'package:alarm_play/core/providers/alarm_provider.dart';
import 'package:alarm_play/core/services/alarm_bridge_service.dart';
import 'package:alarm_play/core/services/alarm_scheduler_service.dart';
import 'package:alarm_play/presentations/screens/new_alarm_screen.dart';
import 'package:alarm_play/presentations/widgets/alarm_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => NewAlarmScreen(
                          alarm: alarms[index],
                        ),
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: AlarmCard(
                          alarm: alarms[index],
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
      //           triggerTime: DateTime.now().add(Duration(seconds: 30)));
      //       print('Trigger Alarm Executed');
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

  // estos metodos son la forma de usar el schedule alarm y el cancel alarm metiante el alarmSchedulerProvider.
  // se instancia el provider en un objeto y con notacion de punto se utlizan sus metodos

//   Future<void> scheduleAlarm(Alarm alarm) async {
//   final scheduler = ref.read(alarmSchedulerProvider);
//   await scheduler.schedule(alarm);
// }

// Future<void> cancelAlarm(int id) async {
//   final scheduler = ref.read(alarmSchedulerProvider);
//   await scheduler.cancel(id);
// }
}
