import 'package:fixit/common/base_image_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../common/bordered_button.dart';
import '../../common/color_constants.dart';
import '../app_header.dart';
import '../bottomSubPages/controller/my_bookings_controller.dart';
import '../splash/map_screen.dart';
import 'chat_screen.dart';

class ServiceDetail extends StatefulWidget {
  String location;
  String distance;
  int index;
  int serviceId;
  String? user;
  String latitude;
  String longitude;
  String description;
  String category;
  String amount;
  bool ischat;
  String? image;
  ServiceDetail(
      {Key? key,
      required this.image,
      required this.user,
      required this.distance,
      required this.latitude,
      required this.longitude,
      required this.description,
      required this.location,
      required this.index,
      required this.serviceId,
      required this.amount,
      required this.ischat,
      required this.category})
      : super(key: key);

  @override
  State<ServiceDetail> createState() => _ServiceDetailState();
}

class _ServiceDetailState extends State<ServiceDetail> {
  MyBookingsController controller = Get.find<MyBookingsController>();
  @override
  void initState() {
    print("ID:- ${widget.serviceId}");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(5.h),
            child: AppHeader(
              title: "Service Details".tr,
              showBackIcon: true,
              isBackIcon: true,
            )),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: 2.h,),
              Stack(children: [
                SizedBox(
                  width: 100.w,
                  height: 60.h,
                  child: MapScreen(
                      latitude: double.parse(widget.latitude),
                      longitude: double.parse(widget.longitude)),
                ),
                Positioned(
                    top: 20.sp,
                    left: 20.sp,
                    right: 20.sp,
                    child: Center(
                      child: Container(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/locPin.svg",
                                  color: ColorConstants.primaryColor,
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    width: 50.h,
                                    child: Text(
                                      overflow: TextOverflow.visible,
                                      textAlign: TextAlign.start,
                                      widget.location,
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onTertiary),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    )),
              ]),
              Container(
                height: 8.h,
                decoration: BoxDecoration(
                  color: Theme.of(Get.context!)
                      .colorScheme
                      .primaryContainer,
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
                            Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                height: 6.h,
                                width: 12.w,
                                child: BaseImageNetwork(
                                  fit: BoxFit.fill,
                                  link: widget.image ?? "",
                                )),
                            SizedBox(
                              width: 2.w,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.user ?? "",
                                  style:  TextStyle(
                                      color: Theme.of(Get.context!)
                                          .colorScheme
                                          .onTertiary,
                                      fontSize: 14),
                                ),
                                // Text(
                                //   widget.category,
                                //   style: const TextStyle(
                                //       color: ColorConstants.subheadingTextDark,
                                //       fontSize: 14),
                                // ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${widget.amount} IQD",
                            style:  TextStyle(
                                color: Theme.of(Get.context!)
                                    .colorScheme
                                    .onTertiary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SvgPicture.asset(
                                "assets/images/locator.svg",
                                color: ColorConstants.primaryColor,
                              ),
                              Text(
                                "${widget.distance} ${"km".tr}",
                                style:  TextStyle(
                                  color: Theme.of(Get.context!)
                                      .colorScheme
                                      .onTertiary,
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
              // Visibility(
              //   visible: controller.allBookingdataList[widget.index].isClientConfirm == 1,
              //   child: GestureDetector(
              //       onTap: () async {
              //         controller
              //             .startServiceRequests(widget.serviceId)
              //             .then((value) async {});
              //         Get.back();
              //         controller.tabController.animateTo(1);
              //         await controller.getActiveBookingsData();
              //       },
              //       child: BorderedButton(
              //         width: 1,
              //         isReversed: true,
              //         text: "Start Service".toUpperCase(),
              //       )),
              // ),todo
              // Visibility(
              //   visible: controller.allBookingdataList[widget.index].status == 1 && controller.allBookingdataList[widget.index].isClientConfirm == 0,
              //   child: GestureDetector(
              //       onTap: () async {
              //         controller
              //             .cancelServiceRequest(widget.serviceId)
              //             .then((value) async {});
              //         Get.back();
              //         controller.tabController.animateTo(1);
              //         await controller.getActiveBookingsData();
              //       },
              //       child: BorderedButton(
              //         width: 1,
              //         isReversed: true,
              //         text: "Cancel".toUpperCase(),
              //       )),
              // ),todo
              Padding(
                padding: EdgeInsets.only(left: 15.sp, right: 15.sp, top: 10.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${'Customer description'.tr} :",
                      style: TextStyle(
                          color: Theme.of(Get.context!).colorScheme.onTertiary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 1.h,),
                    Text(
                      widget.description,
                      style: TextStyle(
                          color: Theme.of(Get.context!).colorScheme.onTertiary,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              if (widget.ischat)
                GestureDetector(
                    onTap: () => Get.to(ChatScreen(
                          name: controller
                              .allBookingdataList[widget.index].user?.name,
                          image: controller
                              .allBookingdataList[widget.index].user?.image,
                          isSend: true,
                        )),
                    child: BorderedButton(
                      width: 1,
                      text: "Chat".tr.toUpperCase(),
                      isReversed: true,
                      icon: "assets/images/chat_icon.svg",
                    )),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ));
  }
}
