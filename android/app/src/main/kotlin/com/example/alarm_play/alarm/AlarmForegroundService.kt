package com.example.alarm_play.alarm

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.Intent
import android.os.Build
import android.os.IBinder
import android.util.Log

class AlarmForegroundService : Service() {

    companion object {
        const val CHANNEL_ID = "alarm_foreground"
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
}