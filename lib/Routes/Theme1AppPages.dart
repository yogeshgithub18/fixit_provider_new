import 'package:get/get_navigation/src/routes/get_route.dart';

import '../ui_screens/auth/login.dart';
import '../ui_screens/home/home.dart';
import '../ui_screens/locations/set_locations_screen.dart';
import '../ui_screens/splash/splash_view.dart';
import 'app_routes.dart';

class Theme1AppPages {
  static const initial = Routes.splash;
  static final routes = [
    GetPage(name: Routes.splash, page: () => const SplashView()),
    GetPage(name: Routes.loginScreen, page: () => const LoginScreen()),
    GetPage(name: Routes.setLocation, page: () => const SetLocation()),
    GetPage(name: Routes.home, page: () => Home()),
  ];
}
