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
    private var pendingAlarmId: Int? = null

    override fun onCreate(savedInstanceState: Bundle?){
        super.onCreate(savedInstanceState)
        android.util.Log.d(
            "ALARM_APP",
            "MainActivity onCreate"
        )  
        // Guardamos la accion si el app fue despertada por la alarma
        handleIntent(intent)
        
    }

    override fun onNewIntent(intent: Intent){
        super.onNewIntent(intent)
        // Si el app estaba abierta en background, se procede nuevo Intent
        handleIntent(intent)
    }

    private fun handleIntent(intent: Intent){
        if(intent.hasExtra("alarm_id")){
            pendingAlarmId = intent.getIntExtra("alarm_id", -1)
        }
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
            "alarm_play/alarm_receiver"
            ).setMethodCallHandler {call, result -> 
            if(call.method == "getPendingAlarm"){
                result.success(pendingAlarmId)
                // se limpia el valor, para que no se ejecute en futuros reinicios
                pendingAlarmId = null 
            }else{
                result.notImplemented()
            }
        }

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
