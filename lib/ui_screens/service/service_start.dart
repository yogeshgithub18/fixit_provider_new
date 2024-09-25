import 'package:fixit/ui_screens/app_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/bordered_button.dart';
import '../../common/color_constants.dart';

class ServiceStart extends StatefulWidget {
  const ServiceStart({Key? key,}) : super(key: key);
  @override
  State<ServiceStart> createState() => _ServiceStartState();
}
class _ServiceStartState extends State<ServiceStart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(5.h),
            child:  AppHeader(
              title: "Service Start".tr,
              showBackIcon: true,
              isBackIcon: true,
            )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              Stack(children: [
                SizedBox(
                    width: 100.w,
                    height: 65.h,
                    child: Image.asset(
                      "assets/images/long_map.png",
                      fit: BoxFit.fitWidth,
                    )),
                Positioned(
                    top: 20.sp,
                    left: 20.sp,
                    right: 20.sp,
                    child: Center(
                      child: Container(
                          height: 5.h,
                          width: 90.w,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.sp),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/locPin.svg",
                                  color: Theme.of(Get.context!)
                                      .colorScheme
                                      .onTertiary,
                                ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                Text(
                                  " 123,  location  dum...,  iraq".tr,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onTertiary),
                                ),
                              ],
                            ),
                          )),
                    )),
              ]),
              Container(
                height: 8.h,
                decoration: BoxDecoration(
                  color: ColorConstants.buttonBgColor,
                  borderRadius: BorderRadius.circular(1),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 15.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                                height: 10.h,
                                width: 10.w,
                                child: Image.asset("assets/images/avtar.png")),
                            SizedBox(
                              width: 2.w,
                            ),
                             Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Mrinal Joe".tr,
                                  style: const TextStyle(
                                      color: ColorConstants.subheadingTextDark,
                                      fontSize: 14),
                                ),
                                Text(
                                  "Plumber".tr,
                                  style: const TextStyle(
                                      color: ColorConstants.subheadingTextDark,
                                      fontSize: 14),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "\$ 200.00",
                            style: TextStyle(
                                color: ColorConstants.subheadingTextDark,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SvgPicture.asset(
                                "assets/images/locator.svg",
                                color: ColorConstants.primaryColor,
                              ),
                            Text(
                                " 3.5 km".tr,
                                style: const TextStyle(
                                  color: ColorConstants.subheadingTextDark,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                width: 4.w,
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              GestureDetector(
                  // onTap: () => Get.to( ChatScreen(name: co,)),
                  child: BorderedButton(
                    width: 1,
                    text: "Chat".tr.toUpperCase(),
                    isReversed: true,
                    icon: "assets/images/chat_icon.svg",
                  ))
            ],
          ),
        ));
  }
}
