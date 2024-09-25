import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart' as flutter_local_notifications;
class PushNotificationService {
  String? token;
  Future<void> setupInteractedMessage() async {
   // await Firebase.initializeApp();
    enableIOSNotifications();
    await registerNotificationListeners();
  }

  Future<void>  registerNotificationListeners() async {
    final AndroidNotificationChannel channel = androidNotificationChannel();
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@drawable/ic_launcher');
    const DarwinInitializationSettings iOSSettings =
    DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    const InitializationSettings initSettings = InitializationSettings(android: androidSettings, iOS: iOSSettings);
    flutterLocalNotificationsPlugin.initialize(initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {
       print("open here payload---${details.payload}");
       if(details.payload!=null && details.payload!.isNotEmpty){
         Map <String,dynamic> data=json.decode(details.payload!);
         print("open here in---");
          handleClick(data);
       }
      },
    );
   // onMessage is called when the app is in foreground and a notification is received
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      print("onMessage push----${message?.data}");
      print("onMessage notification push----${message?.notification?.title}");
      print("onMessage push----${message}");
      final RemoteNotification? notification = message!.notification;
      final AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        print("onMessage push----${message}");
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          flutter_local_notifications.NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              largeIcon: DrawableResourceAndroidBitmap('@drawable/ic_launcher'),
              //icon: android.smallIcon,
              color: Colors.red,
              colorized: true,
            ),
           iOS: const DarwinNotificationDetails()
          ),
          payload: message.data.toString(),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification ? android = message.notification?.android;
      Map<String,dynamic>  notificationData = message.data;
      print(" onMessageOpenedApp notificationData---->>$notificationData");
      handleClick(notificationData);
    });

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print("getInitialMessage");
      if (message != null) {
      }
    });
    getToken();
  }

  handleClick(Map<String,dynamic>data){
    if((data['requestId']??'').isNotEmpty){
     // Get.to(JobsDetails(id: data['requestId']!));
    }
  }

  Future<void> getToken() async {
   // token = Platform.isAndroid? await FirebaseMessaging.instance.getToken():await FirebaseMessaging.instance.getAPNSToken();
    token =await FirebaseMessaging.instance.getToken();
   // await storage.setString("token",token??'');
    print("FCm TOken==========>>>>> $token");
  }

  Future<void> enableIOSNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }
  AndroidNotificationChannel androidNotificationChannel() =>
      const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description:
        'This channel is used for important notifications.', // description
        importance: Importance.max,
        ledColor: Colors.white,
      );
}