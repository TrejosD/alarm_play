package com.diegotrejos.AlarmPlay.channels

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.Intent
import com.diegotrejos.AlarmPlay.alarm.AlarmReceiver
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import android.content.Context
import android.os.Build

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

        val safeContext = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
        context.createDeviceProtectedStorageContext()
        } else {
            context
        }
        val prefs = safeContext.getSharedPreferences("active_alarms_prefs", Context.MODE_PRIVATE)
        prefs.edit().putLong("alarm_$alarmId", triggerMillis).apply()
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
        val safeContext = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
        context.createDeviceProtectedStorageContext()
        } else {
        context
        }
        val prefs = safeContext.getSharedPreferences("active_alarms_prefs", Context.MODE_PRIVATE)
        prefs.edit().remove("alarm_$alarmId").apply()
        android.util.Log.d(
            "ALARM_APP",
            "Alarm cancelled $alarmId"
        )
    }
}