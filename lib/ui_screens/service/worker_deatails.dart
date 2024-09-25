import 'package:fixit/backend/modal/all_bookings_data_model.dart';
import 'package:fixit/backend/modal/booking_detail_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../common/color_constants.dart';
import '../app_header.dart';
import '../bottomSubPages/controller/my_bookings_controller.dart';

class WorkerDetails extends StatefulWidget {
  Data bookingData;
  WorkerDetails({Key? key, required this.bookingData}) : super(key: key);

  @override
  State<WorkerDetails> createState() => _WorkerDetailsState();
}

class _WorkerDetailsState extends State<WorkerDetails> {
  MyBookingsController controller = Get.find<MyBookingsController>();
  BookingDetailData? bookingDetailData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(5.h),
            child:  AppHeader(
              title: "Service Details".tr,
              showBackIcon: true,
              isBackIcon: true,
            )),
        body: Column(
            children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: EdgeInsets.only(
                  left: 6.sp, right: 6.sp, bottom: 10.sp),
              padding: EdgeInsets.all(15.sp),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.bookingData.category?.name ?? '',
                            style: TextStyle(
                                color: Theme.of(Get.context!)
                                    .colorScheme
                                    .onTertiary,
                                fontSize: 18),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            "${controller.formatDateString(widget.bookingData.createdAt ?? '')}, ${controller.formatTimeString(widget.bookingData.createdAt ?? '')}",
                            style: const TextStyle(
                                color: ColorConstants.hintColor,
                                fontSize: 16.0),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          SizedBox(
                            width: 60.w,
                            child: Text(
                              "${widget.bookingData.userLocation?.streetNo ?? ''}, ${widget.bookingData.userLocation?.streetName ?? ''}, ${widget.bookingData.userLocation?.location ?? ''}",
                              style: TextStyle(
                                  color: Theme.of(Get.context!)
                                      .colorScheme
                                      .onTertiary,
                                  fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/images/locator.svg",
                                color: Theme.of(Get.context!)
                                    .colorScheme
                                    .onTertiary,
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              Text(
                                "${widget.bookingData.distance != null ? widget.bookingData.distance.toStringAsFixed(2) + '${"km".tr}' : 'N/A'}",
                                style: TextStyle(
                                    color: Theme.of(Get.context!)
                                        .colorScheme
                                        .onTertiary,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Flexible(
                        child : Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${widget.bookingData.subcategory?.price ?? 'N/A'} IQD",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(Get.context!).colorScheme.onTertiary,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    height: 5.h,
                    width: 85.w,
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(Icons.watch_later_rounded),
                        Text("${"Time Slot".tr} : ${widget.bookingData.fromTime} - ${widget.bookingData.toTime}")///todo
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: const BorderRadiusDirectional.all( Radius.circular(5)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Price Specification".tr,
                      style: TextStyle(
                          color: Theme.of(Get.context!).colorScheme.tertiary,
                          fontSize: 18.0),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Price".tr,
                          style: TextStyle(
                              color: Theme.of(Get.context!).colorScheme.onTertiary,
                              fontSize: 16.0),
                          ),
                          Text("${widget.bookingData.subcategory?.price} IQD",
                          style: TextStyle(
                              color: Theme.of(Get.context!)
                                  .colorScheme
                                  .onTertiary,
                              fontSize: 16.0),
                        ),
                      ],
                    ),
                    if(widget.bookingData.addonPrice!=null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "AddOn Service".tr,
                          style: TextStyle(
                              color: Theme.of(Get.context!).colorScheme.onTertiary,
                              fontSize: 16.0),
                        ),
                        Text(
                          "${widget.bookingData.addonPrice} IQD",
                          style: TextStyle(
                              color: Theme.of(Get.context!)
                                  .colorScheme
                                  .onTertiary,
                              fontSize: 16.0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]));
  }
}
