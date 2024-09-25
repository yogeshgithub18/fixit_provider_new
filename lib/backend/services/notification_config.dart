import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../../firebase_options.dart';
import '../../ui_screens/bottomSubPages/controller/my_bookings_controller.dart';

class FCMFunctions {
  static final FCMFunctions _singleton = new FCMFunctions._internal();

  FCMFunctions._internal();

  factory FCMFunctions() {
    return _singleton;
  }

  late FirebaseMessaging messaging;

//************************************************************************************************************ */
  /// Create a [AndroidNotificationChannel] for heads up notifications
  late AndroidNotificationChannel channel;

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

//************************************************************************************************************ */

  Future initApp() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
    messaging = FirebaseMessaging.instance;

    // if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    //for IOS Foreground Notification
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future subscripeToTopics(String topic) async {
    await messaging.subscribeToTopic(topic);
  }

  ///Expire : https://firebase.google.com/docs/cloud-messaging/manage-tokens
  Future<String?> getFCMToken() async {
    final fcmToken = await messaging.getToken();
    return fcmToken;
  }

  void tokenListener() {
    messaging.onTokenRefresh.listen((fcmToken) {}).onError((err) {});
  }


  Future<void> clearNotifications() async {
    try {
      await messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      await messaging.getInitialMessage();
    } on PlatformException catch (e) {
      print('Failed to clear notifications: ${e.message}');
    }
  }

  ///Foreground messages
  ///
  ///To handle messages while your application is in the foreground, listen to the onMessage stream.
  Future<void> foreGroundMessageListener() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('A new onMessage event was published!');
      showNotification(message);
      Get.find<MyBookingsController>().notificationCount++;
    });
    await messaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        print(
            'Opened app from terminated state: ${message.notification?.title}');
        // showNotification(message);
        // Add your custom logic to handle notification clicks when the app is opened from a terminated state (on Android)
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      // navigateToScreen(message);
      // showNotification(message);
    });
  }

  void showNotification(RemoteMessage message) {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.high,
    );

    if (Platform.isAndroid) {
      flutterLocalNotificationsPlugin.show(
        message.hashCode,
        message.notification?.title,
        message.notification?.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            importance: Importance.high,
            priority: Priority.defaultPriority,
            ticker: 'ticker',
            icon: "@drawable/ic_launcher",
          ),
        ),
      );
      const InitializationSettings initializationSettings =
          InitializationSettings(
              android: AndroidInitializationSettings('@drawable/ic_launcher'),
              iOS: DarwinInitializationSettings());
          flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onDidReceiveNotificationResponse: (payload) async {
        print("on clivk display${payload.payload}");
        // navigateToScreen(message);
      });
    }
  }

  // void navigateToScreen(RemoteMessage message) {
  //   // Navigate to the desired screen based on the notification data
  //   // You can access the message data using message.data
  //   // Use the Flutter Navigator to navigate to the desired screen
  //   // Example:
  //   if (message != null) {
  //     if (message.data != null) {
  //       print("NAVIGATION ==> ${message.toMap()}");
  //       if (message.data['type'] == 'transactions') {
  //         Get.to(() => WalletScreen());
  //       } else if (message.data['type'] == 'request_money') {
  //         PrintLog("TYPE:- ${message.data['type']}");
  //         Get.to(() => MoneyRequestsScreen());
  //       }
  //       // Navigator.of(Get.context!)
  //       //     .push(MaterialPageRoute(builder: (context) => WalletScreen()));
  //     }
  //   }
  // }
}

final fcmFunctions = FCMFunctions();
