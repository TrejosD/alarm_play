package com.example.alarm_play.alarm

import android.app.Activity
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.view.WindowManager
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import com.example.alarm_play.MainActivity

class AlarmActivity : AppCompatActivity(){

    override fun onCreate(savedInstanceState: Bundle?){
        super.onCreate(savedInstanceState)
        android.util.Log.d(
            "ALARM_PLAY",
            "AlarmActivity onCreate"
        )
        
        setShowWhenLocked(true)
        setTurnScreenOn(true)
        val keyguardManager = getSystemService(android.content.Context.KEYGUARD_SERVICE) as android.app.KeyguardManager
        keyguardManager.requestDismissKeyguard(this, null)
        // Aca vamos a redirigir el app al main actvity.
        val intentToFlutter = Intent(this, MainActivity::class.java).apply{
            // revivir el app, trayendola al frente
            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP)
            // ingresamos un extra para decirle a flutter, vengo de un alarm
            putExtra("action", "LAUNCH_ALARM_SCREEN")
        }

        android.util.Log.d(
            "ALARM_PLAY",
            "AlarmActivity created"
        )
        // iniciamos el main activity del app.
        startActivity(intentToFlutter)
        // Cerramos esta activity intermedio
        finish()
    }

    override fun onResume(){
        super.onResume()
        android.util.Log.d(
            "ALARM_PLAY",
            "AlarmActivity onResume"
        )
    }
}