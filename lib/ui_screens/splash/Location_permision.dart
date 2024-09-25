import 'package:fixit/ui_screens/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/bordered_button.dart';

class LocationPermissionto extends StatefulWidget {
  final bool isShow;
  const LocationPermissionto({super.key, required this.isShow});

  @override
  State<LocationPermissionto> createState() => _LocationPermissiontoState();
}

class _LocationPermissiontoState extends State<LocationPermissionto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.all(20.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Location permission not enabled".tr,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context)
                        .colorScheme
                        .onTertiary),
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Center(
              child: Text(
                widget.isShow ?
                "Sharing Location permission helps us improve your service".tr:"Allow the Location Permission from App Setting",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context)
                        .colorScheme
                        .onTertiary),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Visibility(
        visible: widget.isShow,
        child: Padding(
          padding:EdgeInsets.only(bottom: 20.sp),
          child: SizedBox(
            height: 6.h,
            child: GestureDetector(
                onTap: () {
                  Get.offAll(SplashView());
                },
                child: BorderedButton(
                  width: 1,
                  text: "ALLOW PERMISSION".tr,
                  isReversed: true,
                )
            ),
          ),
        ),
        replacement:Padding(
          padding:EdgeInsets.only(bottom: 20.sp),
          child: SizedBox(
            height: 6.h,
            child: GestureDetector(
                onTap: () async{
                  await openAppSettings();

                  Get.offAll(SplashView());
                },
                child: BorderedButton(
                  width: 1,
                  text: "OPEN SETTING".tr,
                  isReversed: true,
                )
            ),
          ),
        ) ,
      ),
    );
  }
  Future<void> requestPermissionAndCheck() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      // Permission is granted; you can proceed with your logic.
    } else {
      // Permission is not granted; you can open the app settings.
      openAppSettings();
    }
  }
}
