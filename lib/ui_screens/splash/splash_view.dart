import 'package:fixit/storage/base_shared_preference.dart';
import 'package:fixit/storage/sp_keys.dart';
import 'package:fixit/ui_screens/auth/choose_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Routes/app_routes.dart';
import '../../controller/base_controller.dart';
import 'Location_permision.dart';


class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  BaseController controller=Get.put(BaseController());
  @override
  void initState() {

    Future.delayed(const Duration(seconds: 2), () async {
      // bool serviceEnabled;
      // LocationPermission permission;
      // serviceEnabled = await Geolocator.isLocationServiceEnabled();
      // if (!serviceEnabled) {
      //   permission = await Geolocator.requestPermission();
      // }
      // permission = await Geolocator.checkPermission();
      // if (permission == LocationPermission.denied) {
      //   permission = await Geolocator.requestPermission();
      //   if (permission == LocationPermission.denied) {
      //     serviceEnabled = await Geolocator.isLocationServiceEnabled();
      //     Get.to(const LocationPermissionto());
      //     return;
      //     // return Position(latitude:25.8979508,longitude: 84.4877291,timestamp: DateTime.now(), accuracy: 0, altitude: 0, heading: 0, speed: 0, speedAccuracy: 0, altitudeAccuracy: 0, headingAccuracy: 0);
      //   }
      // }
      // if (permission == LocationPermission.deniedForever) {
      //   Get.to(const LocationPermissionto());
      //   return;
      //   // return Position(latitude:25.8979508,longitude: 84.4877291,timestamp: DateTime.now(), accuracy: 0, altitude: 0, heading: 0, speed: 0, speedAccuracy: 0, altitudeAccuracy: 0, headingAccuracy: 0);
      // }
      if (await BaseSharedPreference().getBool(SpKeys().isLoggedIn) ?? false) {
        Get.offAllNamed(Routes.home);
      } else {
        Get.offAll( const ChooseLanguage(pageName: 'splash',));
        // Get.offAndToNamed(Routes.loginScreen);
      }
    });
    super.initState();
    FocusScope.of(Get.context!).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.transparent, width: 0)),
            child: SvgPicture.asset(
              'assets/images/splash.svg',
              height: 30.w,
              width: 30.w,
              color: Theme.of(context).colorScheme.tertiary,
            )),
      ),
    );
  }
}
