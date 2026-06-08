package com.example.alarm_play.alarm

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log
import androidx.core.content.ContextCompat

class AlarmReceiver : BroadcastReceiver(){
    override fun onReceive(
        context: Context,
        intent: Intent
    ){
        Log.d(
            "ALARM_APP",
            "AlarmReceiver triggered"
        )
        val serviceIntent = Intent(
            context,
            AlarmForegroundService:: class.java
            )
        serviceIntent.putExtra(
            "alarm_id",
            intent.getIntExtra("alarm_id", -1)
        )
        ContextCompat.startForegroundService(
            context,
            serviceIntent
        )

        Log.d(
            "ALARM_APP",
            "ForegroundService requested"
        )
    }
}

