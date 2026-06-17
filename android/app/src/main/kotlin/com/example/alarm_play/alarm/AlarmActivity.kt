package com.example.alarm_play.alarm

import android.app.Activity
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.view.WindowManager
import android.widget.TextView
// import io.flutter.embedding.android.FlutterActivity
import androidx.appcompat.app.AppCompatActivity

class AlarmActivity : AppCompatActivity(){

    override fun onCreate(savedInstanceState: Bundle?){
        super.onCreate(savedInstanceState)
        android.util.Log.d(
            "ALARM_PLAY",
            "AlarmActivity onCreate"
        )
        
        setShowWhenLocked(true)
        setTurnScreenOn(true)

        android.util.Log.d(
            "ALARM_PLAY",
            "AlarmActivity created"
        )

        // val textView = TextView(this)

        // textView.text = "Alarm Triggered"

        // textView.textSize = 32f
        // textView.gravity = android.view.Gravity.CENTER
        // setContentView(textView)
    }

    override fun onResume(){
        super.onResume()
        android.util.Log.d(
            "ALARM_PLAY",
            "AlarmActivity onResume"
        )
    }
}