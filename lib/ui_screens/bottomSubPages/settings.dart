import 'package:fixit/common/myTheme.dart';
import 'package:fixit/controller/settings_controller.dart';
import 'package:fixit/ui_screens/auth/choose_language.dart';
import 'package:fixit/ui_screens/splash/Location_permision.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/bordered_button.dart';
import '../../common/color_constants.dart';
import '../../storage/base_shared_preference.dart';
import '../../storage/sp_keys.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  ThemeController themecontroller = Get.put(ThemeController());
  SettingsController controller = Get.put(SettingsController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotif();
  }

  Future<void> getNotif() async {
    Future.delayed(Duration.zero, () async {
      controller.isNotificationSend.value =
          await BaseSharedPreference().getString(SpKeys().isNotification) == "1";
      print("staus${controller.isNotificationSend.value}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: EdgeInsets.only(top: 30.sp),
          child: Column(
            children: [
              Text(
                "Settings".tr,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 25),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.notifications,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onTertiary),
                                SizedBox(
                                  width: 1.w,
                                ),
                                Text(
                                  "Notifications".tr,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onTertiary),
                                )
                              ],
                            ),
                            Obx(() => Switch(
                                  activeColor:
                                      Colors.white, // Color when switch is ON
                                  activeTrackColor: ColorConstants.primaryColor, // Track color when switch is ON
                                  inactiveThumbColor: Colors.grey, // Color when switch is OFF
                                  inactiveTrackColor: Colors.grey[300],
                                  value: controller.isNotificationSend.value,
                                  onChanged: (value) {
                                    setState(() {
                                      controller.isNotificationSend.value = value;
                                      controller.notificationSetting();
                                    });
                                  },
                                )),
                          ],
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset('assets/images/language@3x.png',
                                    height: 25,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onTertiary),
                                SizedBox(
                                  width: 1.w,
                                ),
                                Text("Change Language".tr,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onTertiary),
                                )
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(const ChooseLanguage(
                                  pageName: 'setting',
                                ));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: 15.sp),
                                child: SvgPicture.asset("assets/images/long_arrow.svg"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 5.h),
          child: Column(
            children: [
              Text(
                "App version 1.0".tr,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 2.h,
              ),
              GestureDetector(
                  onTap: () {
                    controller.logout();
                  },
                  child: BorderedButton(
                    width: 1,
                    text: "LOGOUT".tr,
                    isReversed: true,
                  ))
            ],
          ),
        )
      ]),
    );
  }
}
