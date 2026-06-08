package com.example.alarm_play.channels

import android.content.Intent
import com.example.alarm_play.alarm.AlarmReceiver
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import android.content.Context

class AlarmMethodChannel(
    private val context:Context):MethodChannel.MethodCallHandler {
    override fun onMethodCall(
        call: MethodCall,
        result: MethodChannel.Result
    ){
        when (call.method){
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
}