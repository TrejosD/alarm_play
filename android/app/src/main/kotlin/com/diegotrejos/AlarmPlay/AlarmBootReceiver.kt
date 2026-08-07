package com.diegotrejos.AlarmPlay

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import android.util.Log
import com.diegotrejos.AlarmPlay.alarm.AlarmReceiver

class AlarmBootReceiver : BroadcastReceiver() {

    override fun onReceive(
        context: Context,
        intent: Intent
    ) {
        // capturamos los reinicios del dispositivo
        val action = intent.action
        if (action == Intent.ACTION_BOOT_COMPLETED ||
            action == "androind.intent.action.QUICKBOOT_POWERON" ||
            action == "com.htc.intent.action.QUICKBOOT_POWERON") {
                Log.d("ALARM_APP","Dispositivo Xiaomi reinicio destectado")
            val safeContext = if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.N){
                context.createDeviceProtectedStorageContext()
            }else{
                context
            }
            // tomamos los datos en sharedPreferences
            val prefs = safeContext.getSharedPreferences("active_alarms_prefs", Context.MODE_PRIVATE)
            val allEntries = prefs.all
            val alarmManager = context.getSystemService(Context.ALARM_SERVICE) as AlarmManager
            val currentTime = System.currentTimeMillis()

            // iteramos sobre los datos
            for((key, value)in allEntries){
                if(key.startsWith("alarm_") && value is Long){
                    try{
                        val alarmId = key.replace("alarm_","").toInt()
                        val triggerMillis = value
                    
                    // esto descartar la alarma si debio sonar mientra el dispotivo estaba apagado
                    if(triggerMillis < currentTime){
                        Log.d("ALARM_APP","La alarma ${alarmId} ya expiro mientrar el dispositivo estaba apagado")
                        prefs.edit().remove(key).apply()
                        continue
                    }
                    val alarmIntent = Intent(context, AlarmReceiver::class.java).apply{
                        putExtra("alarm_id", alarmId)
                    }
                    val pendingIntent = PendingIntent.getBroadcast(
                        context,
                        alarmId,
                        alarmIntent,
                        PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE   
                    )

                    alarmManager.setExactAndAllowWhileIdle(
                        AlarmManager.RTC_WAKEUP,
                        triggerMillis,
                        pendingIntent
                    )

                    Log.d("ALARM_APP", "Alarma ${alarmId} reagendada con exito tras reinicio")
                }catch (e: Exception){
                    Log.d("ALARM_APP", "Error al intentar reagendar la clave ${key}", e)
                }
            }
            
        }
    }
}
}