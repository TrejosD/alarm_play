package com.example.alarm_play

import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import com.example.alarm_play.channels.AlarmMethodChannel
import android.content.Intent
import android.os.Bundle
import android.view.WindowManager
import android.os.Build
import com.example.alarm_play.alarm.AlarmForegroundService
import com.ryanheise.audioservice.AudioServiceActivity
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.EventChannel
import com.example.alarm_play.channels.AlarmEventChannel
import com.example.alarm_play.channels.XiaomiMethodChannel


class MainActivity : AudioServiceActivity() {

    override fun onCreate(savedInstanceState: Bundle?){
        super.onCreate(savedInstanceState)
        android.util.Log.d(
            "ALARM_APP",
            "MainActivity onCreate"
        )  
        
        // setShowWhenLocked(true)
        // setTurnScreenOn(true)

        // window.addFlags(
        //     WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON
        // )

        // android.util.Log.d(
        //     "ALARM_PLAY",
        //     "MainActivity created"
        // )
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

        android.util.Log.d(
            "ALARM_APP",
            "MainActivity configureFlutter"
        )

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O_MR1) {
        setShowWhenLocked(true)
        setTurnScreenOn(true)
    } else {
        @Suppress("DEPRECATION")
        window.addFlags(
            WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED or
            WindowManager.LayoutParams.FLAG_TURN_SCREEN_ON
        )
    }
    window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
        "alarm_play/xiaomi"
        ).setMethodCallHandler(
            XiaomiMethodChannel(this)
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
