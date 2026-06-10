package com.example.alarm_play.channels

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.Intent
import com.example.alarm_play.alarm.AlarmReceiver
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import android.content.Context

class AlarmMethodChannel(
    private val context:Context):MethodChannel.MethodCallHandler {
    override fun onMethodCall(
        call: MethodCall,
        result: MethodChannel.Result
    ){
        when (call.method){
            "scheduleAlarm" -> {
                val alarmId = call.argument<Int>("alarmId")
                ?: return

                val triggerMillis = call.argument<Long>("triggerMillis")
                ?: return
                scheduleAlarm(alarmId, triggerMillis)
                result.success(true)
            }

            "cancelAlarm" -> {
                val alarmId = call.argument<Int>("alarmId")
                ?: return
                cancelAlarm(alarmId)
                result.success(true)
            }
            
            "triggerAlarm" -> {
                val receiver = AlarmReceiver()
                receiver.onReceive(
                    context, Intent()
                )
                result.success(true)
            }
            else -> {
                result.notImplemented()
            }
            
        }
        
    }

    private fun scheduleAlarm(
        alarmId: Int,
        triggerMillis: Long
        ){
            android.util.Log.d(
                "ALARM_APP",
                "scheduleAlarm desde AlarmMethodChannel"
            )
        val alarmManager = context.getSystemService(
            Context.ALARM_SERVICE
            ) as AlarmManager

        val intent = Intent(
            context,
            AlarmReceiver::class.java
        )

        intent.putExtra(
            "alarm_id",
            alarmId
        )
        val pendingIntent = PendingIntent.getBroadcast(
            context,
            alarmId,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or
            PendingIntent.FLAG_IMMUTABLE
        )
        alarmManager.setExactAndAllowWhileIdle(
            AlarmManager.RTC_WAKEUP,
            triggerMillis,
            pendingIntent
        )
        android.util.Log.d(
            "ALARM_APP",
            "Alarm Scheduled: $alarmId"
        )
    }

    private fun cancelAlarm(alarmId: Int){
        val alarmManager = context.getSystemService(
            Context.ALARM_SERVICE
        ) as AlarmManager

        val intent = Intent(
            context,
            AlarmReceiver::class.java
        )
        val pendingIntent =
        PendingIntent.getBroadcast(
            context,
            alarmId,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or
            PendingIntent.FLAG_IMMUTABLE
        )
        alarmManager.cancel(
            pendingIntent
        )

        android.util.Log.d(
            "ALARM_APP",
            "Alarm cancelled $alarmId"
        )
    }
}