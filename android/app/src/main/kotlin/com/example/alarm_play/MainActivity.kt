package com.example.alarm_play

import android.content.Intent
import android.os.Bundle
import com.example.alarm_play.alarm.AlarmForegroundService
import com.ryanheise.audioservice.AudioServiceActivity
import io.flutter.embedding.android.FlutterActivity


class MainActivity : AudioServiceActivity() {
    override fun onCreate(savedInstanceState: Bundle?){
        super.onCreate(savedInstanceState)
        android.util.Log.d(
            "ALARM_APP",
            "MainActivity onCreate"
        )
        val intent = Intent(
            this,
            AlarmForegroundService::class.java
        )
        startForegroundService(intent)
    }
}
