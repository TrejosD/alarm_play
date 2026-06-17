package com.example.alarm_play.alarm

import com.example.alarm_play.channels.AlarmEventChannel
import com.example.alarm_play.MainActivity
import android.app.Notification
import androidx.core.app.NotificationCompat
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.app.PendingIntent
import android.content.Intent
import android.os.Build
import android.os.PowerManager
import android.os.IBinder
import android.util.Log

class AlarmForegroundService : Service() {

    private var wakeLock: PowerManager.WakeLock? = null

    companion object {
        const val CHANNEL_ID = "alarm_foreground"
    }


    private fun acquireWakeLock(){
        val powerManager = 
        getSystemService(POWER_SERVICE) as PowerManager

        wakeLock = powerManager.newWakeLock(
            PowerManager.PARTIAL_WAKE_LOCK,
            "alarm_play:alarm_wakelock"
        )
        wakeLock?.acquire(10 * 60 * 1000L)
    }

    override fun onCreate() {
        super.onCreate()

        createNotificationChannel()
        val intent = Intent(
    this,
    AlarmForegroundService::class.java
)

startForegroundService(intent)
        
    }


    override fun onStartCommand(
        intent: Intent?,
        flags: Int,
        startId: Int
    ): Int {


        val fullScreenPendingIntent = PendingIntent.getActivity(
            this,
            0,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or
            PendingIntent.FLAG_IMMUTABLE
        )

        val notification = NotificationCompat.Builder(
            this,
            CHANNEL_ID
        )
            .setContentTitle("Alarm Service")
            .setPriority(NotificationCompat.PRIORITY_MAX)
            .setCategory(NotificationCompat.CATEGORY_ALARM)
            .setFullScreenIntent(fullScreenPendingIntent, true)
            .setContentText("Alarm running")
            .setSmallIcon(android.R.drawable.ic_lock_idle_alarm)
            .build()
        

        val alarmId = intent?.getIntExtra(
            "alarm_id",
            -1
        ) ?: -1
        if(alarmId == -1){
            
            return START_NOT_STICKY
        }
        startForeground(
            alarmId,
            notification
        )


        AlarmEventChannel.sentAlarmTriggered(
            alarmId
        )
        
        acquireWakeLock()
        launchAlarmActivity(alarmId)


        return START_STICKY
    }

    override fun onBind(intent: Intent?): IBinder? {
        return null
    }

    private fun createNotificationChannel() {

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {

            val channel = NotificationChannel(
                CHANNEL_ID,
                "Alarm Foreground",
                NotificationManager.IMPORTANCE_HIGH
            )

            val manager =
                getSystemService(NotificationManager::class.java)

            manager.createNotificationChannel(channel)
        }
    }

    private fun launchAlarmActivity(alarmId: Int){
        
        val intent = Intent(
            this,
            MainActivity::class.java
        ).apply {
            flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_SINGLE_TOP or Intent.FLAG_ACTIVITY_CLEAR_TOP
            putExtra("alarm_id", alarmId)
        }
        

        try{
        startActivity(intent)
        
        }catch(e: Exception){
        android.util.Log.d(
            "ALARM_APP",
            "Error launching Activity",
            e
        )
        }
        
    }

    override fun onDestroy(){
        wakeLock?.let{
            if(it.isHeld){
                it.release()
            }
        }
        super.onDestroy()
    }
}