import 'package:fixit/common/color_constants.dart';
import 'package:fixit/controller/notification_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../app_header.dart';
import '../base_pagination_footer.dart';
import 'controller/my_bookings_controller.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  NotificationController controller = Get.put(NotificationController());
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    await controller.getNotificationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(10.h),
        child: Stack(children: [
          AppHeader(
            title: "Notifications".tr,
            showBackIcon: false,
          ),
          Positioned(
              bottom: 20.sp,
              right: 20.sp,
              child: PopupMenuButton(
                icon: Icon(
                  Icons.more_horiz,
                  color: Theme.of(Get.context!).colorScheme.onTertiary,
                ),
                position: PopupMenuPosition.under,
                color: ColorConstants.primaryColor,
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'item1',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Mark as All Read'.tr,
                            style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'item2',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Mark as All UnRead'.tr,
                            style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'item3',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Delete All'.tr,
                            style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
                onSelected: (value) {
                  // Handle the selection of the menu item
                  print('Selected item: $value');
                  if (value == "item1") {
                    controller.markNotification(1);
                  } else if (value == "item2") {
                    controller.markNotification(2);
                  } else if (value == "item3") {
                    controller.markNotification(3);
                  }
                },
              ))
        ]),
      ),
      body: Obx(() => SmartRefresher(
    footer: const BasePaginationFooter(),
    controller: controller.refreshController,
    enablePullDown: true,
    enablePullUp: true,
    onLoading: () {
    controller.getNotificationData(refreshType: "load");
    },
    onRefresh: () {
    controller.getNotificationData(refreshType: "refresh");
    },
    child:controller.isLoader.value?Center(child: CircularProgressIndicator()):controller.notificationdataList.isEmpty
            ? Center(
                child: Text(
                  'NO NOTIFICATION'.tr,
                  style: TextStyle(
                      color: Theme.of(Get.context!).colorScheme.onTertiary,
                      fontSize: 18),
                ),
              )
            : ListView.builder(
                itemCount: controller.notificationdataList.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        controller.deleteNotification(
                            controller.notificationdataList[index].id);
                      });
                    },
                    background: Container(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      child: const Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Icon(
                            Icons.delete,
                            size: 40,
                            color: ColorConstants.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            controller.readNotification(id: controller.notificationdataList[index].id.toString());
                          },
                          child: Container(
                            width: 90.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                                color: controller.notificationdataList[index].status == 1 ?Theme.of(context).colorScheme.primaryContainer:Colors.green[300],
                              // color: Theme.of(context)
                              //     .colorScheme
                              //     .primaryContainer,
                            ),
                            child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  controller.notificationdataList[index].message ?? '',
                                  style: TextStyle(
                                      fontWeight: controller
                                          .notificationdataList[index].status == 1?FontWeight.normal:FontWeight.bold,
                                      color:  Theme.of(Get.context!)
                                              .colorScheme
                                              .tertiary),
                                ),
                              ),
                              subtitle: Padding(
                                padding: EdgeInsets.only(left: 18.sp, bottom: 15.sp),
                                child: Text(
                                  controller.getDate(DateTime.parse(controller
                                      .notificationdataList[index].createdAt.toString())),
                                  style: TextStyle(
                                      fontWeight: controller
                                          .notificationdataList[index].status == 1?FontWeight.normal:FontWeight.bold,
                                      color: controller.notificationdataList[index].status == 1
                                          ? Theme.of(Get.context!)
                                              .colorScheme
                                              .error
                                          : Theme.of(Get.context!)
                                              .colorScheme
                                              .tertiary),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ))
      ) );
  }
}
