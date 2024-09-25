import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:fixit/pushNotification.dart';
import 'package:fixit/ui_screens/auth/choose_language_controller.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fixit/backend/services/notification_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'Routes/Theme1AppPages.dart';
import 'change_language/change_language.dart';
import 'common/myTheme.dart';
import 'controller/base_controller.dart';
import 'package:permission_handler/permission_handler.dart';

import 'firebase_options.dart';
String deviceToken = '';
const String apiItemLimit = "10";
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(name: "provider",options: DefaultFirebaseOptions.currentPlatform,);
  await setupFlutterNotifications();
}
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    ledColor: Colors.white,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}
void main() async {
  Get.put(ChooseLanguageController());
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  try {
    await fcmFunctions.initApp();
    deviceToken = await FirebaseMessaging.instance.getToken() ?? "1234";
    print(deviceToken);
  } catch (_) {
    deviceToken = "1234";
  }
  print("deviceToken: $deviceToken");
  final ThemeController themeController = ThemeController();
  await themeController.loadSavedThemeMode();
  HttpOverrides.global = MyHttpOverrides();
  Get.lazyPut<BaseController>(()=>BaseController(), fenix: true);
  runApp(const MyApp());
  RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    // App received a notification when it was killed
  }
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.notification.isDenied.then((bool value) {
    if (value) {
      Permission.notification.request();
    }
  },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
    fcmFunctions.foreGroundMessageListener();
    // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white54,
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      statusBarBrightness: Brightness.light, // For iOS (dark icons)
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ResponsiveSizer(
      builder: (context, orientation, deviceType) {
        return GestureDetector(
          onTap: () {
            if (FocusManager.instance.primaryFocus!.hasFocus) {
              FocusManager.instance.primaryFocus!.unfocus();
            }
          },
          child: GetMaterialApp(
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                child: child!,
              );
            },
            title: 'FixIt Provider',
            themeMode: brightness == Brightness.light
                ? ThemeMode.light
                : ThemeMode.dark,
            theme: MyTheme.lightTheme,
            darkTheme: MyTheme.darkTheme,
            initialRoute: Theme1AppPages.initial,
            getPages: Theme1AppPages.routes,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', 'US'), // English
              Locale('ar', 'SA'), // Arabic
              // Add other supported locales
            ],
            locale:Locale(Get.find<ChooseLanguageController>().selectedLanguage.value),
            translations: LocaleString(),
          ),
        );
      },
    );
  }
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}