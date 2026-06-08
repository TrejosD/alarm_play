package com.example.alarm_play.alarm

import com.example.alarm_play.MainActivity
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
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

        Log.d(
            "ALARM_APP",
            "Wakelock acquired"
        )

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

        Log.d(
            "ALARM_APP",
            "ForegroundService started"
        )
        
        acquireWakeLock()
        launchAlarmActivity()

        val notification = Notification.Builder(
            this,
            CHANNEL_ID
        )
            .setContentTitle("Alarm Service")
            .setContentText("Alarm running")
            .setSmallIcon(android.R.drawable.ic_lock_idle_alarm)
            .build()

        startForeground(
            999,
            notification
        )

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

    private fun launchAlarmActivity(){
        val intent = Intent(
            this,
            MainActivity::class.java
        )
        intent.addFlags(
            Intent.FLAG_ACTIVITY_NEW_TASK or
            Intent.FLAG_ACTIVITY_SINGLE_TOP or
            Intent.FLAG_ACTIVITY_CLEAR_TOP
        )
        startActivity(intent)
        Log.d(
            "ALARM_APP",
            "MainActivity launch"
        )
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