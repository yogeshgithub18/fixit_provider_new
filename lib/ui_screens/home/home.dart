import 'package:fixit/common/color_constants.dart';
import 'package:fixit/ui_screens/bottomSubPages/my_profile.dart';
import 'package:fixit/ui_screens/bottomSubPages/notifications.dart';
import 'package:fixit/ui_screens/bottomSubPages/settings.dart';
import 'package:fixit/ui_screens/home/home_controller.dart';
import 'package:fixit/ui_screens/bottomSubPages/my_bookings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../bottomSubPages/controller/my_bookings_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeController controller = Get.put(HomeController());
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() =>Scaffold(
      body:  buildPages(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: controller.currentIndex.value,
        elevation: 0.0,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 1,
        unselectedFontSize: 1,
        enableFeedback: true,
        backgroundColor:Theme.of(context).scaffoldBackgroundColor,
        onTap: (index) {
          controller.currentIndex.value = index;
        },
        items:[
           createBottomNavItem(context, Icons.home, 0),
           createBottomNavItem(context, Icons.settings, 1),
           createBottomNavItem(context, Icons.notifications, 2),
           createBottomNavItem(context, Icons.person, 3),
          ],
      )),
    );
  }

  BottomNavigationBarItem createBottomNavItem(
      BuildContext context, IconData iconData, int index) {
    return BottomNavigationBarItem(
      icon: Obx(() =>
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              if(index==2)
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Icon(iconData, color:controller.currentIndex.value == index? ColorConstants.primaryColor:Theme.of(context).colorScheme.tertiary,size: 25.sp,),
                    Visibility(
                      visible: Get.find<MyBookingsController>().notificationCount>0,
                      child: Container(
                          width:5.w,
                          height:2.h,
                          decoration:BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color:Theme.of(context).colorScheme.primaryContainer
                          ),
                          child: Center(child:Text(Get.find<MyBookingsController>().notificationCount.toString(),style: TextStyle(color: Colors.red,fontSize: 14.sp,fontWeight: FontWeight.bold)))),
                    ),
                  ],
                ),
              if(index!=2)
             Icon(
              iconData,
              color: controller.currentIndex.value == index
                  ? ColorConstants.primaryColor
                  : Theme.of(context).colorScheme.tertiary,
              size: 25.sp,
             ),
           controller.currentIndex.value == index
              ? Container(
                  width: 1.w,
                  height: 1.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorConstants.primaryColor,
                  ),
                )
              : const SizedBox(),
        ]),
      ),
      label: '',
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }

  Widget buildPages() {
    switch (controller.currentIndex.value) {
      case 0:
        return MyBookings();
      case 1:
        return const Settings();
      case 2:
        return const Notifications();
      case 3:
        return const MyProfile();
      default:
        return MyBookings();
    }
  }
}
