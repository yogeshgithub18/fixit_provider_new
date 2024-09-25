import 'package:fixit/ui_screens/app_header.dart';
import 'package:fixit/ui_screens/service/controller/status_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/bordered_button.dart';
import '../../common/color_constants.dart';

class ChangeStatus extends StatefulWidget {
  int serviceID;
  int status;
  ChangeStatus({super.key, required this.serviceID, required this.status});

  @override
  State<ChangeStatus> createState() => _ChangeStatusState();
}

class _ChangeStatusState extends State<ChangeStatus> {
  StatusController controller = Get.put(StatusController());
  @override
  void initState() {
    print("SERVICE ID:- ${widget.serviceID}");
    // print("STATUS:- ${widget.status}");
    getStatus();
    super.initState();
  }

  getStatus() {
    int index =
        controller.list.indexWhere((element) => element.id == widget.status);
    print("STATUS:- ${index}");
    controller.selectedStatus = index;
    controller.update();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(5.h),
          child: const AppHeader(
            title: '',
            showBackIcon: true,
            isBackIcon: true,
          )),
      body: GetBuilder<StatusController>(builder: (controller) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Change Status".tr,
                    style: TextStyle(
                      fontSize: 25,
                      color: Theme.of(Get.context!).colorScheme.tertiary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    "Lorem Ipsum is simply dummy text \n of the printing and typesetting \n industry.".tr,
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Theme.of(Get.context!).colorScheme.onTertiary),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                ],
              ),
            ),
            ListView.builder(
              itemCount: controller.list.length,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = controller.list[index];
                return InkWell(
                    onTap: () {
                      controller.selectedStatus = index;
                      print(index);
                      print("ID: - ${controller.list[index].id}");
                      controller.update();
                    },
                    child: Container(
                      height: 6.h,
                      width: 90.w,
                      margin: EdgeInsets.symmetric(
                          vertical: 10.sp, horizontal: 20.sp),
                      decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: controller.selectedStatus == index
                                  ? ColorConstants.primaryColor
                                  : Theme.of(context)
                                      .colorScheme
                                      .primaryContainer)),
                      child: Padding(
                          padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item.title,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onTertiary,
                                    fontSize: 16),
                              ),
                              if (controller.selectedStatus == index)
                                const Icon(
                                  Icons.done,
                                  color: ColorConstants.primaryColor,
                                  size: 25,
                                )
                            ],
                          )),
                    ));
              },
            ),
            SizedBox(
              height: 3.h,
            ),
            GestureDetector(
                onTap: ()async {
                 await controller.changeRequestStatus(widget.serviceID, controller.list[controller.selectedStatus].id);
                 Get.back(result: controller.list[controller.selectedStatus].id);
                 },
                child: BorderedButton(
                  width: 1,
                  text: "SUBMIT".tr,
                  isReversed: true,
                )),
          ],
        );
      }),
    );
  }
}
