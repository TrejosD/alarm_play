package com.example.alarm_play

import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import com.example.alarm_play.channels.AlarmMethodChannel
import android.content.Intent
import android.os.Bundle
import com.example.alarm_play.alarm.AlarmForegroundService
import com.ryanheise.audioservice.AudioServiceActivity
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.EventChannel
import com.example.alarm_play.channels.AlarmEventChannel


class MainActivity : AudioServiceActivity() {
    override fun onCreate(savedInstanceState: Bundle?){
        super.onCreate(savedInstanceState)
        android.util.Log.d(
            "ALARM_APP",
            "MainActivity onCreate"
        )  
    }

    override fun onResume(){
        super.onResume()
        android.util.Log.d(
            "ALARM_APP",
            "MainActivity onResume"
        )
    }
    
    override fun configureFlutterEngine(flutterEngine:FlutterEngine){
        super.configureFlutterEngine(
            flutterEngine
        )
        
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "alarm_play/alarm"
        ).setMethodCallHandler(
            AlarmMethodChannel(this)
        )
        
        EventChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "alarm_play/alarm_events"
        ).setStreamHandler(
            AlarmEventChannel
            )
    }
}
