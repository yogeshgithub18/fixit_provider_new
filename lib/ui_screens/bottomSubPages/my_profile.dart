import 'package:fixit/common/base_image_network.dart';
import 'package:fixit/common/color_constants.dart';
import 'package:fixit/controller/profile_controller.dart';
import 'package:fixit/ui_screens/profileSubPage/edit_profile.dart';

import 'package:fixit/ui_screens/profileSubPage/privacy_policy.dart';
import 'package:fixit/ui_screens/profileSubPage/termCondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../backend/api_end_points.dart';
import '../../backend/base_api.dart';
import '../../backend/modal/page_response.dart';
import '../../common/base_overlays.dart';
import '../../common/bordered_button.dart';
import '../app_header.dart';
import '../profileSubPage/aboutUs_real.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  PageData data = PageData();
  ProfileController controller = Get.put(ProfileController());
  @override
  void initState() {
    controller.getProfile();
    super.initState();
  //  getData();
  }

  getData() async {
    await BaseAPI()
        .get(url: ApiEndPoints().privacyPolicy, showLoader:false)
        .then((value) {
      if (value?.statusCode == 200) {
        setState(() {});
      } else {
        BaseOverlays().showSnackBar(message: "Something Went Wrong!!".tr, title: "Error".tr);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (controller) {
      return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(4.h),
            child: Stack(
                children: [
              const AppHeader(
                title: "",
                showBackIcon: false,
              ),
              Positioned(
                  top: 20.sp,
                  bottom: 0.sp,
                  right: 10.sp,
                  child: PopupMenuButton(
                    icon: const Icon(Icons.help,
                        color: ColorConstants.primaryColor, size: 30),
                    color: ColorConstants.primaryColor,
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'item1',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                controller.launchPhoneMail("mailto:${controller.helpEmail.value}");
                              },
                              child: Row(
                                children: [
                                  const Icon(Icons.mail_outline,
                                      color: Colors.white),
                                  SizedBox(
                                    width: 1.w,
                                  ),
                                  Obx(() =>
                                      Text(controller.helpEmail.value,
                                          style:
                                          const TextStyle(color: Colors.white)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'item2',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                              controller.launchPhoneDialer(
                                controller.helpNumber.value,
                              );
                              },
                              child: Row(
                                children: [
                                   const Icon(Icons.call, color: Colors.white),
                                  SizedBox(
                                    width: 1.w,
                                  ),
                           Obx(() =>
                                     Text(controller.helpNumber.value,
                                        style:
                                            const TextStyle(color: Colors.white)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ))
            ]),
          ),
          // floatingActionButton:Padding(
          //   padding:EdgeInsets.only(top:35.sp),
          //   child: Align(
          //     alignment: Alignment.topRight,
          //     child: FloatingActionButton(
          //       backgroundColor:Theme.of(context).scaffoldBackgroundColor ,
          //       child: Container(
          //          decoration: const BoxDecoration(
          //            shape: BoxShape.circle
          //          ),
          //         child: const Icon(Icons.help,color: ColorConstants.primaryColor,size:35,)),
          //         onPressed: () {
          //
          //     },),
          //   ),
          // ),
          body: Padding(
            padding: EdgeInsets.only(top: 35.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 16.h,
                  width: 33.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(150.0),
                  ),
                  child: BaseImageNetwork(
                    fit: BoxFit.cover,
                    borderRadius: 150,
                    link: controller.data.image ?? "",
                    concatBaseUrl: false,
                    errorWidget: Image.asset(
                      "assets/images/profile.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  controller.data.category?.name ?? '',
                  style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.tertiary),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  controller.data.name ?? '',
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.tertiary),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  controller.data.email ?? '',
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(Get.context!).colorScheme.onTertiary),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  controller.data.phone ?? '',
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(Get.context!).colorScheme.onTertiary),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 2.h,
                ),
                GestureDetector(
                    onTap: () {
                      Get.to(const EditProfile())?.then((value) {
                        controller.getProfile();
                      });
                    },
                    child: BorderedButton(
                      width: 1,
                      text: "Edit Profile".tr.toUpperCase(),
                      isReversed: true,
                    )),
                SizedBox(
                  height: 3.h,
                ),
                Container(
                  height: 22.h,
                  width: 88.w,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => Get.to(const PrivacyPolicy()),
                          child: Padding(
                            padding: EdgeInsets.only(left: 12.sp, right: 12.sp),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.shield,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onTertiary,
                                    ),
                                    SizedBox(
                                      width: 1.w,
                                    ),
                                    Text(
                                      "Privacy Policy".tr,
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
                                    Get.to(const PrivacyPolicy());
                                  },
                                  child: SvgPicture.asset(
                                      "assets/images/long_arrow.svg"),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 12.sp,
                              right: 12.sp,
                              top: 12.sp,
                              bottom: 12.sp),
                          child: Divider(
                            height: 1.h,
                            color: ColorConstants.divderColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Get.to(const TermsConditions()),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 12.0, right: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  // mainAxisAlignment:MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(
                                      Icons.file_copy,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onTertiary,
                                    ),
                                    SizedBox(
                                      width: 1.w,
                                    ),
                                    Text(
                                      "Term & Conditions".tr,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onTertiary),
                                    )
                                  ],
                                ),
                                InkWell(
                                  onTap: () => Get.to(const TermsConditions()),
                                  child: SvgPicture.asset(
                                      "assets/images/long_arrow.svg"),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 12.sp,
                              right: 12.sp,
                              top: 12.sp,
                              bottom: 12.sp),
                          child: Divider(
                            height: 1.h,
                            color: ColorConstants.divderColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Get.to(const AboutUsReal()),
                          child: Padding(
                            padding: EdgeInsets.only(left: 12.sp, right: 12.sp),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  // mainAxisAlignment:MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(Icons.warning_rounded,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onTertiary),
                                    SizedBox(
                                      width: 1.w,
                                    ),
                                    Text(
                                      "About Us".tr,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onTertiary),
                                    )
                                  ],
                                ),
                                InkWell(
                                  onTap: () => Get.to(const AboutUsReal()),
                                  child: SvgPicture.asset(
                                      "assets/images/long_arrow.svg"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ));
    });
  }
}
