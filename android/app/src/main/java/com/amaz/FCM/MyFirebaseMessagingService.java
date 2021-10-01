package com.amaz.FCM;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.AsyncTask;
import android.os.PowerManager;
import android.util.Log;

import com.amaz.MainActivity;
import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;

import org.json.JSONObject;

import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Map;

public class MyFirebaseMessagingService extends FirebaseMessagingService {
    private static final String TAG = "MyFirebaseMsgService";
    private NotificationUtils mNotificationUtils;

    @SuppressWarnings("unused")
    public MyFirebaseMessagingService() {
    }

    @Override
    public void onNewToken(String token) {
        super.onNewToken(token);
        Log.e(TAG, "Firebase token: " + token);

    }

    @Override
    public void onMessageReceived(RemoteMessage remoteMessage) {
        super.onMessageReceived(remoteMessage);
        mNotificationUtils = new NotificationUtils(this);

        JSONObject jsonObject = null;
        Map<String, String> data = remoteMessage.getData();
        jsonObject = new JSONObject(data);
        Log.e(TAG, "Notification : " + jsonObject.toString());
        try {
            String title = jsonObject.optString("title");
            String message = jsonObject.optString("message");
            String image = jsonObject.optString("image");
            if (image != null && image.length() > 0) {
                //sendAppNotification(title, message, jsonObject.toString());
                new sendNotification(title, message, image).execute();
            } else {
                sendAppNotification(title, message, jsonObject.toString());
            }

        } catch (Exception e) {
            e.printStackTrace();
            Log.e("error", e.getMessage());
        }

    }

    private void sendAppNotification(String title, String message, String data) {
        Log.e("TAG", "App Notification");

        Intent intent = null;
        intent = new Intent(getApplicationContext(), MainActivity.NotificationReceiver.class);
        intent.putExtra("data", data);

        intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_SINGLE_TOP |
                Intent.FLAG_ACTIVITY_NEW_TASK);
        mNotificationUtils.getManager().notify((int) System.currentTimeMillis(),
                mNotificationUtils.getNotificationBuilder(intent, title, message));
        @SuppressLint("InvalidWakeLockTag")
        PowerManager.WakeLock wakeLock = ((PowerManager) getSystemService(POWER_SERVICE)).newWakeLock(PowerManager.FULL_WAKE_LOCK
                | PowerManager.ACQUIRE_CAUSES_WAKEUP, "PowerWakeLock");

        wakeLock.acquire(15000);
    }

    private class sendNotification extends AsyncTask<String, Void, Bitmap> {
        String title;
        String message;
        String image;

        public sendNotification(String title, String message, String image) {
            super();
            this.title = title;
            this.message = message;
            this.image = image;
        }

        @Override
        protected Bitmap doInBackground(String... params) {

            InputStream in;
            try {

                in = new URL(image).openStream();
                Bitmap bmp = BitmapFactory.decodeStream(in);
                return bmp;

            } catch (MalformedURLException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
            return null;
        }

        @Override
        protected void onPostExecute(Bitmap result) {

            super.onPostExecute(result);
            try {
                Intent intent = null;
                intent = new Intent(getApplicationContext(), MainActivity.NotificationReceiver.class);

                intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_SINGLE_TOP |
                        Intent.FLAG_ACTIVITY_NEW_TASK);
                mNotificationUtils.getManager().notify((int) System.currentTimeMillis(),
                        mNotificationUtils.getNotificationBuilder(intent, title, message, result));
                @SuppressLint("InvalidWakeLockTag")
                PowerManager.WakeLock wakeLock = ((PowerManager) getSystemService(POWER_SERVICE)).newWakeLock(PowerManager.FULL_WAKE_LOCK
                        | PowerManager.ACQUIRE_CAUSES_WAKEUP, "PowerWakeLock");

                wakeLock.acquire(15000);

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

}
