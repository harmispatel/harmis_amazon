package com.amaz;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.Signature;
import android.util.Base64;
import android.util.Log;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class MainActivity extends FlutterActivity {

    private static final String CHANNEL = "com.amaz.channel";
    private static BinaryMessenger flutterView;
    MethodChannel methodChannel;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        flutterView = flutterEngine.getDartExecutor().getBinaryMessenger();
        methodChannel = new MethodChannel(flutterView, CHANNEL);
        methodChannel.setMethodCallHandler(this::onMethodCall);
        getHashkey();

    }

    public void getHashkey(){
        try {
            PackageInfo info = getPackageManager().getPackageInfo(
                    "com.amaz",
                    PackageManager.GET_SIGNATURES);
            for (Signature signature : info.signatures) {
                MessageDigest md = MessageDigest.getInstance("SHA");
                md.update(signature.toByteArray());
                Log.d("KeyHash:", Base64.encodeToString(md.digest(), Base64.DEFAULT));
            }
        } catch (PackageManager.NameNotFoundException e) {

        } catch (NoSuchAlgorithmException e) {

        }
    }

    private void onMethodCall(MethodCall call, MethodChannel.Result result) {
        if (call.method.equals("add")) {

        } else if (call.method.equals("cancel")) {
        }
    }


    public static class NotificationReceiver extends BroadcastReceiver {
        private final String TAG = NotificationReceiver.class.getSimpleName();

        @Override
        public void onReceive(Context context, Intent intent) {
            if (intent != null && intent.getExtras() != null) {
                if (flutterView != null) {
                    MethodChannel channel = new MethodChannel(flutterView, CHANNEL);
                    channel.invokeMethod("notification", intent.getStringExtra("data"));
                } else {
                    Intent intent1 = new Intent(context, MainActivity.class);
                    intent1.putExtra("route", "splash-page");
                    intent1.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                    context.startActivity(intent1);
                }
            }
        }

    }
}
