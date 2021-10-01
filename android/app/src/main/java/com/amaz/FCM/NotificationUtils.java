package com.amaz.FCM;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.ContextWrapper;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.media.RingtoneManager;
import android.net.Uri;
import android.os.Build;

import androidx.core.app.NotificationCompat;
import androidx.core.app.TaskStackBuilder;

import com.amaz.R;

import static android.app.Notification.DEFAULT_ALL;

/**
 * Created by Paras Andani
 */

public class NotificationUtils extends ContextWrapper {

    public static final String ANDROID_CHANNEL_ID = "com.tegdar.ANDROID";
    public static final String ANDROID_CHANNEL_NAME = "TEGDAR ANDROID CHANNEL";
    private NotificationManager mManager;
    private Context context;

    public NotificationUtils(Context base) {
        super(base);
        this.context = base;
        createChannels();
    }

    public NotificationManager getManager() {
        if (mManager == null) {
            mManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
        }
        return mManager;
    }

    public Notification getNotificationBuilder(Intent intent, String title, String messageBody) {
        TaskStackBuilder stackBuilder = TaskStackBuilder.create(getApplicationContext());
        stackBuilder.addNextIntent(intent);
        /*PendingIntent pendingIntent = stackBuilder.getPendingIntent(
                (int) System.currentTimeMillis(), PendingIntent.FLAG_UPDATE_CURRENT);*/
        PendingIntent pendingIntent = PendingIntent.getBroadcast(this, 0, intent,
                PendingIntent.FLAG_UPDATE_CURRENT);
        Uri alarmSound = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION);

        final Bitmap picture = BitmapFactory.decodeResource(getResources(), R.mipmap.ic_launcher);
        Notification notification = null;
        //Uri notificationSound = Uri.parse(ContentResolver.SCHEME_ANDROID_RESOURCE + "://" + context.getPackageName() + "/" + R.raw.notification_sound);
        Uri notificationSound = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION);
        NotificationCompat.Builder builder = null;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            builder = new NotificationCompat.Builder(this, ANDROID_CHANNEL_ID);
        } else {
            builder = new NotificationCompat.Builder(this);
        }
        builder.setSmallIcon(getNotificationIcon(builder))
                .setLargeIcon(picture)
                .setContentTitle(title)
                .setContentText(messageBody)
                .setTicker(messageBody)
                .setContentIntent(pendingIntent)
                .setDefaults(DEFAULT_ALL)
                .setPriority(NotificationManager.IMPORTANCE_HIGH)
                .setAutoCancel(true)
                .setWhen(System.currentTimeMillis())
                //.setSound(notificationSound)
                //.setVibrate(new long[]{100, 250, 100, 250, 100, 250})
        ;
        notification = builder.build();
        //adding LED lights to notification
       /* notification.defaults |= Notification.DEFAULT_LIGHTS;

        SharedPref sharedPref = SharedPref.getInstance(getApplicationContext());
        if (sharedPref.getIsPlaySound())
            notification.sound = alarmSound;*/

        return notification;
    }

    public Notification getNotificationBuilder(Intent intent, String title, String messageBody, Bitmap image) {
        TaskStackBuilder stackBuilder = TaskStackBuilder.create(getApplicationContext());
        stackBuilder.addNextIntent(intent);
        /*PendingIntent pendingIntent = stackBuilder.getPendingIntent(
                (int) System.currentTimeMillis(), PendingIntent.FLAG_UPDATE_CURRENT);*/
        PendingIntent pendingIntent = PendingIntent.getBroadcast(this, 0, intent,
                PendingIntent.FLAG_UPDATE_CURRENT);
        Uri alarmSound = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION);
        final Bitmap picture = BitmapFactory.decodeResource(getResources(), R.mipmap.ic_launcher);
        Notification notification = null;
        //Uri notificationSound = Uri.parse(ContentResolver.SCHEME_ANDROID_RESOURCE + "://" + context.getPackageName() + "/" + R.raw.notification_sound);
        Uri notificationSound = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION);
        NotificationCompat.Builder builder = null;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            builder = new NotificationCompat.Builder(this, ANDROID_CHANNEL_ID);
        } else {
            builder = new NotificationCompat.Builder(this);
        }
        builder.setSmallIcon(getNotificationIcon(builder))
                .setLargeIcon(picture)
                .setStyle(new NotificationCompat.BigPictureStyle().bigPicture(image))
                .setContentTitle(title)
                .setContentText(messageBody)
                .setTicker(messageBody)
                .setContentIntent(pendingIntent)
                .setDefaults(DEFAULT_ALL)
                .setPriority(NotificationManager.IMPORTANCE_HIGH)
                .setAutoCancel(true)
                .setWhen(System.currentTimeMillis())
        //.setSound(notificationSound)
        //.setVibrate(new long[]{100, 250, 100, 250, 100, 250})
        ;
        notification = builder.build();
        //adding LED lights to notification
       /* notification.defaults |= Notification.DEFAULT_LIGHTS;

        SharedPref sharedPref = SharedPref.getInstance(getApplicationContext());
        if (sharedPref.getIsPlaySound())
            notification.sound = alarmSound;*/

        return notification;
    }

    private int getNotificationIcon(NotificationCompat.Builder notificationBuilder) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            notificationBuilder.setColor(Color.WHITE);
            return R.mipmap.ic_launcher;

        }
        return R.mipmap.ic_launcher;
    }

    public void createChannels() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            // create android channel
            NotificationChannel androidChannel = new NotificationChannel(ANDROID_CHANNEL_ID,
                    ANDROID_CHANNEL_NAME, NotificationManager.IMPORTANCE_DEFAULT);
            // Sets whether notifications posted to this channel should display notification lights
            androidChannel.enableLights(true);
            // Sets whether notification posted to this channel should vibrate.
            androidChannel.enableVibration(true);
            // Sets the notification light color for notifications posted to this channel
            androidChannel.setLightColor(Color.GREEN);
            // Sets whether notifications posted to this channel appear on the lockscreen or not
            androidChannel.setLockscreenVisibility(Notification.VISIBILITY_PRIVATE);

            getManager().createNotificationChannel(androidChannel);
        }
    }

}
