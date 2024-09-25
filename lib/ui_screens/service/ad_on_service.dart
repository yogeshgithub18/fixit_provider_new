import 'package:fixit/common/base_overlays.dart';
import 'package:fixit/ui_screens/bottomSubPages/controller/my_bookings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/bordered_button.dart';
import '../app_header.dart';

class AddOnService extends StatefulWidget {
  int serviceId;
  AddOnService({super.key, required this.serviceId});

  @override
  _AddOnServiceState createState() => _AddOnServiceState();
}

class _AddOnServiceState extends State<AddOnService> {
  MyBookingsController controller = Get.find<MyBookingsController>();
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Addon Service".tr,
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
                  fontSize: 18,
                  color: Theme.of(Get.context!).colorScheme.onTertiary),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 3.h,
            ),
            Container(
              height: 6.h,
              width: 80.w,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: EdgeInsets.all(12.sp),
                child: TextField(
                  controller: controller.addOnAmountCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Add Amount'.tr,
                    hintStyle: TextStyle(
                        color: Theme.of(Get.context!).colorScheme.error),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {},
                ),
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Container(
              height: 20.h,
              width: 80.w,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controller.addOnReasonCtrl,
                  decoration: InputDecoration(
                    hintText: 'Reason'.tr,
                    hintStyle: TextStyle(
                        color: Theme.of(Get.context!).colorScheme.error),
                    border: InputBorder.none,
                  ),
                  maxLines: 5,
                  onChanged: (value) {},
                ),
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            GestureDetector(
                onTap: () {
                  if(controller.addOnReasonCtrl.text.trim().isNotEmpty && controller.addOnAmountCtrl.text.trim().isNotEmpty) {
                    controller.addOnServices(widget.serviceId);
                  }else{
                    BaseOverlays().showSnackBar(message: 'All fields are mandatory'.tr);
                  }
                },
                child: BorderedButton(
                    width: 1, isReversed: true, text: "SUBMIT".tr)),
          ],
        ),
      ),
    );
  }
}
