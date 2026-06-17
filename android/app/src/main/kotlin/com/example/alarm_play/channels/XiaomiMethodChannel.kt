package com.example.alarm_play.channels


import android.app.PendingIntent
import android.content.Intent
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import android.content.Context
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

class XiaomiMethodChannel(private val context: Context): MethodChannel.MethodCallHandler{
    override fun onMethodCall(
        call: MethodCall,
        result: MethodChannel.Result
    ){
        if(call.method.equals("xiaomiPermissionRequest")){

            xiaomiPermissionRequest()
            android.util.Log.d(
                "ALARM_APP",
                "xiaomiPermissionRequest SUCCESS"
            )
            result.success(true)
        
    }else{
            result.notImplemented();
        }
    }

    private fun xiaomiPermissionRequest(){
        android.util.Log.d(
            "ALARM_APP",
            "onXiaomiPermissionRequest"
        )
        try{
        val intent = Intent("miui.intent.action.APP_PERM_EDITOR").apply {
        setClassName("com.miui.securitycenter", "com.miui.permcenter.permissions.PermissionsEditorActivity")
        putExtra("extra_pkname", context.packageName)
        addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        }
        context.startActivity(intent)

        }catch(e: Exception){
            android.util.Log.d(
                "ALARM_APP",
                "Error al abrir permisos Xiaomi"
            )
        }

    }
}