import 'package:fixit/common/base_image_network.dart';
import 'package:fixit/common/base_overlays.dart';
import 'package:fixit/controller/base_controller.dart';
import 'package:fixit/storage/base_shared_preference.dart';
import 'package:fixit/storage/sp_keys.dart';
import 'package:fixit/ui_screens/activated_service_detail.dart';
import 'package:fixit/ui_screens/bottomSubPages/controller/my_bookings_controller.dart';
import 'package:fixit/ui_screens/service/ad_on_service.dart';
import 'package:fixit/ui_screens/service/change_status.dart';
import 'package:fixit/ui_screens/service/service_details.dart';
import 'package:fixit/ui_screens/service/worker_deatails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/bordered_button.dart';
import '../../common/color_constants.dart';
import '../base_pagination_footer.dart';
import '../service/chat_screen.dart';

class MyBookings extends StatefulWidget {
  const MyBookings({super.key});

  @override
  State<MyBookings> createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> with SingleTickerProviderStateMixin {
  MyBookingsController controller = Get.put(MyBookingsController());
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    controller.isAvailable.value=(BaseSharedPreference().getInt(SpKeys().isAvailable)??0)==0?false:true;
    controller.currentIndex.value =0;
     tabController=TabController(length: 3, vsync: this)..addListener(() {
      if (!(tabController.indexIsChanging)) {
        controller.currentIndex.value =tabController.index;
        if (controller.currentIndex.value == 0||controller.currentIndex.value == 1) {
          controller.getAllBookingsData();
        }
        if (controller.currentIndex.value == 2) {
          controller.getCompleteBookingsData();
        }
      }
    });
    getLocation();
    controller.getAllBookingsData();
    controller.getNotificationCount();
  }


  getLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      print("serviceEnabled--$serviceEnabled");
      if (!serviceEnabled) {
        permission = await Geolocator.requestPermission();
      }

      permission = await Geolocator.checkPermission();
      print("permission--$permission");
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          serviceEnabled = await Geolocator.isLocationServiceEnabled();
          BaseOverlays()
              .showSnackBar(message: 'Location permissions are denied'.tr);
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        BaseOverlays().showSnackBar(
            message:
                'Location permissions are permanently denied, we cannot request permissions.'
                    .tr);
        return;
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print("location---$position");
      double latitude = position.latitude;
      double longitude = position.longitude;
      controller.sendProviderLocation(latitude, longitude);
    } catch (e) {
      BaseOverlays().showSnackBar(message: "Location not fetched properly".tr);
      // Handle other location-related errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: 28.sp, bottom: 10.sp, left: 15.sp, right: 15.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    height: 35.sp,
                    width: 35.sp,
                    child:Obx(() => BaseImageNetwork(
                      fit: BoxFit.cover,
                      borderRadius: 150,
                      link: Get.find<BaseController>().user?.value.image,
                      concatBaseUrl: false,
                      errorWidget: Image.asset(
                        "assets/images/profile.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
                  Row(
                    children: [
                      Text(
                        "Available".tr,
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.tertiary),
                        textAlign: TextAlign.center,
                      ),
                     Obx(() => Switch(
                        activeColor: Colors.white, // Color when switch is ON
                        activeTrackColor: ColorConstants
                            .primaryColor, // Track color when switch is ON
                        inactiveThumbColor:
                            Colors.grey, // Color when switch is OFF
                        inactiveTrackColor: Colors.grey[300],
                        value: controller.isAvailable.value,
                        onChanged: (value) async {
                          controller.isAvailable.value = value;
                          await controller.statusSetting();
                        },
                      )),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: Theme.of(context).colorScheme.primaryContainer, // Active status bar color
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                onTap: (index) {},
                labelPadding: EdgeInsets.all(2.sp),
                controller: tabController,
                indicatorColor: ColorConstants.primaryColor,
                tabs: [
                  _buildTab('Requests'.tr, 0),
                  _buildTab('Accepted'.tr, 1),
                  _buildTab('Completed'.tr, 2),
                ],
              ),
            ),
             Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  _buildTabContent(0),
                  _buildTabAcceptContent(1),
                  _buildCompleteContent('Completed'.tr, 2),
                ],
              ),
            ),
          ],
        )
      );
  }

  Widget _buildTab(String title, int index) {
    return  Container(
      padding: EdgeInsets.all(1.sp),
      width: 30.w,
      child: Tab(
        child:Obx(() => Text(
          title,
          style: TextStyle(
            color: controller.currentIndex.value == index
                ? ColorConstants.primaryColor
                : Theme.of(context).colorScheme.onTertiary,
          ),
        ),
      ),
    ));
  }

  Widget _buildTabContent(int tab) {
    return Obx(() => SmartRefresher(
      footer: const BasePaginationFooter(),
      controller: controller.refreshController,
      enablePullDown: true,
      enablePullUp: true,
      onLoading: (){
        controller.getAllBookingsData(refreshType: "load");
      },
      onRefresh: (){
        controller.getAllBookingsData(refreshType: "refresh");
      },
      child: controller.allBookingdataList.isEmpty
              ? Center(
                child: Text(
                  'NO REQUEST'.tr,
                  style: TextStyle(
                      color: Theme.of(Get.context!).colorScheme.onTertiary,
                      fontSize: 18),
                ),
              )
              : ListView.builder(
                  itemCount: controller.allBookingdataList.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  padding: EdgeInsets.all(10.sp),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(
                            ServiceDetail(
                              index: index,
                              image: controller
                                  .allBookingdataList[index]
                                  .user
                                  ?.image ??
                                  '',
                              user: controller
                                  .allBookingdataList[index]
                                  .user
                                  ?.name ??
                                  '',
                              latitude: controller
                                  .allBookingdataList[index]
                                  .userLocation
                                  ?.latitude ??
                                  '',
                              longitude: controller
                                  .allBookingdataList[index]
                                  .userLocation
                                  ?.longitude ??
                                  '',
                              location:
                              "${controller.allBookingdataList[index].userLocation?.streetNo ?? ''}, ${controller.allBookingdataList[index].userLocation?.streetName ?? ''}, ${controller.allBookingdataList[index].userLocation?.location ?? ''}",
                              serviceId: controller
                                  .allBookingdataList[index].id!,
                              amount: controller
                                  .allBookingdataList[index]
                                  .subcategory
                                  ?.price ??
                                  '',
                              description: controller
                                  .allBookingdataList[index]
                                  .description!,
                              category: controller
                                  .allBookingdataList[index]
                                  .category
                                  ?.name ??
                                  '',
                              distance: controller
                                  .allBookingdataList[index]
                                  .distance !=
                                  null
                                  ? double.parse(controller
                                  .allBookingdataList[index]
                                  .distance
                                  .toString())
                                  .toStringAsFixed(2)
                                  : 'N/A',
                              ischat: false,
                            ),
                            transition: Transition.upToDown,
                            duration:
                            const Duration(milliseconds: 300));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 8.sp, right: 8.sp, bottom: 10.sp),
                        padding: EdgeInsets.all(15.sp),
                        decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .primaryContainer,
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.allBookingdataList[index]
                                          .category
                                          ?.name ??
                                          '',
                                      style: TextStyle(
                                          color:
                                          Theme.of(Get.context!)
                                              .colorScheme
                                              .onTertiary,
                                          fontSize: 18),
                                    ),
                                    SizedBox(
                                      height: .2.h,
                                    ),
                                    Text(
                                      controller.allBookingdataList[index]
                                          .subcategory
                                          ?.name??
                                          '',
                                      style: TextStyle(
                                          color:
                                          Theme.of(Get.context!)
                                              .colorScheme
                                              .onTertiary,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: .2.h,
                                    ),
                                    Text(
                                      controller.allBookingdataList[index].date ?? '',
                                      style: TextStyle(
                                          color:
                                          Theme.of(Get.context!)
                                              .colorScheme
                                              .error,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: .5.h,
                                    ),
                                    SizedBox(
                                      width: 60.w,
                                      child: Text(
                                        "${controller.allBookingdataList[index].userLocation?.streetNo ?? ''}, ${controller.allBookingdataList[index].userLocation?.streetName ?? ''}, ${controller.allBookingdataList[index].userLocation?.location ?? ''}",
                                        style: TextStyle(
                                            color:
                                            Theme.of(Get.context!)
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
                                          color:
                                          Theme.of(Get.context!)
                                              .colorScheme
                                              .onTertiary,
                                        ),
                                        SizedBox(
                                          width: 1.w,
                                        ),
                                        Text(
                                          "${controller.allBookingdataList[index].distance != null ? double.parse(controller.allBookingdataList[index].distance.toString()).toStringAsFixed(2) : 'N/A'} ${"km".tr}",
                                          style: TextStyle(
                                              color: Theme.of(
                                                  Get.context!)
                                                  .colorScheme
                                                  .onTertiary,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Flexible(
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "${controller.allBookingdataList[index].subcategory?.price ?? 'N/A'} IQD",
                                        style: TextStyle(
                                            fontWeight:
                                            FontWeight.bold,
                                            color:
                                            Theme.of(Get.context!)
                                                .colorScheme
                                                .onTertiary,
                                            fontSize: 20),
                                      ),
                                      // SizedBox(
                                      //   height: 3.h,
                                      // ),
                                      // if (tab == 0)
                                      // GestureDetector(
                                      //   onTap: () async {
                                      //     // if(controller.allBookingdataList[index].status == 1 || controller.allBookingdataList[index].isClientConfirm == 1){
                                      //     //   new
                                      //     // }else{
                                      //       controller.acceptBookingRequest(controller.allBookingdataList[index].id).then((value) async {});
                                      //       Get.back();
                                      //       //controller.tabController.animateTo(1);
                                      //       await init();
                                      //    // }
                                      //
                                      //   },
                                      // Column(
                                      //   children: [
                                      //     Container(
                                      //       decoration: BoxDecoration(
                                      //           color: ColorConstants
                                      //               .primaryColor,
                                      //           borderRadius:
                                      //               BorderRadius
                                      //                   .circular(
                                      //                       20)),
                                      //       // child: Center(
                                      //       //     child: Padding(
                                      //       //       padding:  EdgeInsets.all(10.sp),
                                      //       //       child: Text(/*controller.allBookingdataList[index].status == 1 ? controller.allBookingdataList[index].isClientConfirm == 1 ? "Start Service" :
                                      //       //   "In Process" : */ "Accept".tr.toUpperCase(),
                                      //       //         style: const TextStyle(
                                      //       //             color: ColorConstants.white,
                                      //       //             fontSize: 14),
                                      //       //       ),
                                      //       //     ))
                                      //     ),
                                      //     // SizedBox(
                                      //     //   height: 1.h,
                                      //     // ),
                                      //     // GestureDetector(
                                      //     //   onTap: ()async{
                                      //     //     controller.rejectBookingRequest(controller.allBookingdataList[index].id).then((value) async {});
                                      //     //     Get.back();
                                      //     //     //controller.tabController.animateTo(1);
                                      //     //     await init();
                                      //     //   },
                                      //     //   child: Container(
                                      //     //       decoration: BoxDecoration(
                                      //     //           color: Colors.red,
                                      //     //           borderRadius: BorderRadius.circular(20)),
                                      //     //       child: Center(
                                      //     //           child: Padding(
                                      //     //             padding: EdgeInsets.all(10.sp),
                                      //     //             child: Text(/*controller.allBookingdataList[index].status == 1 ? controller.allBookingdataList[index].isClientConfirm == 1 ? "Start Service" :
                                      //     //             "In Process" : */ "REJECT".tr,
                                      //     //         style: const TextStyle(
                                      //     //               color: ColorConstants.white,
                                      //     //               fontSize: 14.0),
                                      //     //       ),
                                      //     //           ))),
                                      //     // ),
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Container(
                              // height: 5.h,
                              // width: 85.w,
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor,
                                  borderRadius:
                                  BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Icon(
                                        Icons.watch_later_rounded),
                                    Text(
                                        "${"Time Slot".tr} : ${controller.allBookingdataList[index].fromTime} - ${controller.allBookingdataList[index].toTime}")

                                    ///todo
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    // if(controller.allBookingdataList[index].status == 1 || controller.allBookingdataList[index].isClientConfirm == 1){
                                    //   new
                                    // }else{
                                    controller
                                        .acceptBookingRequest(controller.allBookingdataList[index].id).then((value) async {});
                                    Get.back();
                                    //controller.tabController.animateTo(1);
                                    await controller.getAllBookingsData();;
                                    // }
                                  },
                                  child: Container(
                                      height: 5.h,
                                      width: 40.w,
                                      decoration: BoxDecoration(
                                          color: ColorConstants
                                              .primaryColor,
                                          borderRadius:
                                          BorderRadius.circular(
                                              20)),
                                      child: Center(
                                          child: Padding(
                                            padding:
                                            EdgeInsets.all(10.sp),
                                            child: Text(
                                              /*controller.allBookingdataList[index].status == 1 ? controller.allBookingdataList[index].isClientConfirm == 1 ? "Start Service" :
                                                "In Process" : */
                                              "Accept".tr.toUpperCase(),
                                              style: const TextStyle(
                                                  color: ColorConstants
                                                      .white,
                                                  fontSize: 14),
                                            ),
                                          ))),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    controller
                                        .rejectBookingRequest(
                                        controller
                                            .allBookingdataList[
                                        index]
                                            .id)
                                        .then((value) async {});
                                    Get.back();
                                    //controller.tabController.animateTo(1);
                                    await controller.getAllBookingsData();;
                                  },
                                  child: Container(
                                      height: 5.h,
                                      width: 40.w,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                          BorderRadius.circular(
                                              20)),
                                      child: Center(
                                          child: Padding(
                                            padding:
                                            EdgeInsets.all(10.sp),
                                            child: Text(
                                              /*controller.allBookingdataList[index].status == 1 ? controller.allBookingdataList[index].isClientConfirm == 1 ? "Start Service" :
                                                    "In Process" : */
                                              "REJECT".tr,
                                              style: const TextStyle(
                                                  color: ColorConstants
                                                      .white,
                                                  fontSize: 14.0),
                                            ),
                                          ))),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );

                  },
                ),
        ));
  }

  Widget _buildTabAcceptContent(int tab) {
    return Obx(() => SmartRefresher(
      footer: const BasePaginationFooter(),
      controller: controller.refreshController,
      enablePullDown: true,
      enablePullUp: true,
      onLoading: (){
        controller.getAllBookingsData(refreshType: "load");
      },
      onRefresh: (){
        controller.getAllBookingsData(refreshType: "refresh");
      },
      child: controller.allBookingdataList.isEmpty
              ? Center(
                child: Text(
                  'NO REQUEST'.tr,
                  style: TextStyle(
                      color: Theme.of(Get.context!).colorScheme.onTertiary,
                      fontSize: 18),
                ),
              )
              : ListView.builder(
                  itemCount: controller.allBookingdataList.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  padding: EdgeInsets.all(10.sp),
                  itemBuilder: (BuildContext context, int index) {
                    return  GestureDetector(
                                onTap: () async {
                                  if (controller.allBookingdataList[index].serviceProviderStatus != 0) {
                                    await Get.to(ActivatedServiceDetail(
                                      bookingData: controller.allBookingdataList[index],
                                    ));
                                    controller.getAllBookingsData();
                                  } else {
                                    Get.to(ServiceDetail(
                                          image: controller
                                                  .allBookingdataList[index]
                                                  .user
                                                  ?.image ??
                                              '',
                                          user: controller
                                                  .allBookingdataList[index]
                                                  .user
                                                  ?.name ??
                                              '',
                                          latitude: controller
                                                  .allBookingdataList[index]
                                                  .userLocation
                                                  ?.latitude ??
                                              '',
                                          longitude: controller
                                                  .allBookingdataList[index]
                                                  .userLocation
                                                  ?.longitude ??
                                              '',
                                          index: index,
                                          location:
                                              "${controller.allBookingdataList[index].userLocation?.streetNo ?? ''},${controller.allBookingdataList[index].userLocation?.streetName ?? ''}, ${controller.allBookingdataList[index].userLocation?.location ?? ''}",
                                          serviceId: controller
                                              .allBookingdataList[index].id!,
                                          amount: controller
                                                  .allBookingdataList[index]
                                                  .subcategory
                                                  ?.price ??
                                              '',
                                          description: controller
                                              .allBookingdataList[index]
                                              .description!,
                                          category: controller
                                                  .allBookingdataList[index]
                                                  .category
                                                  ?.name ??
                                              '',
                                          ischat: false,
                                          distance: controller
                                                      .allBookingdataList[index]
                                                      .distance !=
                                                  null
                                              ? double.parse(controller
                                                      .allBookingdataList[index]
                                                      .distance
                                                      .toString())
                                                  .toStringAsFixed(2)
                                              : 'N/A',
                                        ),
                                        transition: Transition.upToDown,
                                        duration: const Duration(milliseconds: 300));
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 8.sp, right: 8.sp, bottom: 10.sp),
                                  padding: EdgeInsets.all(15.sp),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                      borderRadius: BorderRadius.circular(7)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller.allBookingdataList[index]
                                                    .category
                                                    ?.name ??
                                                    '',
                                                style: TextStyle(
                                                    color:
                                                    Theme.of(Get.context!)
                                                        .colorScheme
                                                        .onTertiary,
                                                    fontSize: 18),
                                              ),
                                              SizedBox(
                                                height: .2.h,
                                              ),
                                              Text(
                                                controller.allBookingdataList[index]
                                                    .subcategory
                                                    ?.name??
                                                    '',
                                                style: TextStyle(
                                                    color:
                                                    Theme.of(Get.context!)
                                                        .colorScheme
                                                        .onTertiary,
                                                    fontSize: 16),
                                              ),
                                              SizedBox(
                                                height: .2.h,
                                              ),
                                              Text(
                                                "${controller.allBookingdataList[index].date ?? ''}",
                                                style: TextStyle(
                                                    color:
                                                        Theme.of(Get.context!)
                                                            .colorScheme
                                                            .error,
                                                    fontSize: 16),
                                              ),
                                              SizedBox(
                                                height: .5.h,
                                              ),
                                              SizedBox(
                                                width: 60.w,
                                                child: Text(
                                                  "${controller.allBookingdataList[index].userLocation?.streetNo ?? ''}, ${controller.allBookingdataList[index].userLocation?.streetName ?? ''}, ${controller.allBookingdataList[index].userLocation?.location ?? ''}",
                                                  style: TextStyle(
                                                      color: Theme.of(
                                                              Get.context!)
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
                                                    color:
                                                        Theme.of(Get.context!)
                                                            .colorScheme
                                                            .onTertiary,
                                                  ),
                                                  SizedBox(
                                                    width: 1.w,
                                                  ),
                                                  Text(
                                                    "${controller.allBookingdataList[index].distance != null ? double.parse(controller.allBookingdataList[index].distance.toString()).toStringAsFixed(2) : 'N/A'} ${"km".tr}",
                                                    style: TextStyle(
                                                        color: Theme.of(
                                                                Get.context!)
                                                            .colorScheme
                                                            .onTertiary,
                                                        fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Flexible(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "${controller.allBookingdataList[index].subcategory?.price ?? 'N/A'} IQD",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Theme.of(
                                                              Get.context!)
                                                          .colorScheme
                                                          .onTertiary,
                                                      fontSize: 20),
                                                ),
                                                SizedBox(
                                                  height: 3.h,
                                                ),
                                                // if (tab == 0)
                                                GestureDetector(
                                                  onTap: () async {
                                                    if (controller
                                                            .allBookingdataList[
                                                                index]
                                                            .serviceProviderStatus ==
                                                        0) {
                                                      await controller
                                                          .startServiceRequests(
                                                              controller
                                                                  .allBookingdataList[
                                                                      index]
                                                                  .id);
                                                      controller.getAllBookingsData();
                                                    }
                                                  },
                                                  child: Container(
                                                      padding: EdgeInsets.all(
                                                          8.sp),
                                                      decoration: BoxDecoration(
                                                          color: controller
                                                                      .allBookingdataList[
                                                                          index]
                                                                      .serviceProviderStatus ==
                                                                  0
                                                              ? ColorConstants
                                                                  .primaryColor
                                                                  .withOpacity(
                                                                      0.5)
                                                              : ColorConstants
                                                                  .primaryColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: Center(
                                                          child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2.0),
                                                        child: Text(
                                                          controller.allBookingdataList[index].serviceProviderStatus == 0
                                                              ? "Active".tr
                                                              : "Activated"
                                                                  .tr
                                                                  .toUpperCase(),
                                                          style: const TextStyle(
                                                              color:
                                                                  ColorConstants
                                                                      .white,
                                                              fontSize: 14),
                                                        ),
                                                      ))),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const Icon(
                                                  Icons.watch_later_rounded),
                                              Text(
                                                  "${"Time Slot".tr} :  ${controller.allBookingdataList[index].fromTime} - ${controller.allBookingdataList[index].toTime}")

                                              ///todo
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );

                  },
                ),
        ));
  }

  Widget _buildCompleteContent(String content, int tab) {
    return Obx(() => SmartRefresher(
      footer: const BasePaginationFooter(),
      controller: controller.refreshController,
      enablePullDown: true,
      enablePullUp: true,
      onLoading: (){
        controller.getCompleteBookingsData(refreshType: "load");
      },
      onRefresh: (){
        controller.getCompleteBookingsData(refreshType: "refresh");
      },
      child: controller.completeBookingdataList.isEmpty
            ? Center(
              child: Text(
                'NO REQUEST'.tr,
                style: TextStyle(
                    color: Theme.of(Get.context!).colorScheme.onTertiary,
                    fontSize: 18),
              ),
            )
            : ListView.builder(
                itemCount: controller.completeBookingdataList.length,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(10.sp),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () async {
                      Get.to(
                          WorkerDetails(
                            bookingData:
                                controller.completeBookingdataList[index],
                          ),
                          transition: Transition.upToDown,
                          duration: const Duration(milliseconds: 300));
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 8.sp, right: 8.sp, bottom: 10.sp),
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
                                    controller.completeBookingdataList[index]
                                        .category
                                        ?.name ??
                                        '',
                                    style: TextStyle(
                                        color:
                                        Theme.of(Get.context!)
                                            .colorScheme
                                            .onTertiary,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: .2.h,
                                  ),
                                  Text(
                                    controller.completeBookingdataList[index]
                                        .subcategory
                                        ?.name??
                                        '',
                                    style: TextStyle(
                                        color:
                                        Theme.of(Get.context!)
                                            .colorScheme
                                            .onTertiary,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: .2.h,
                                  ),
                                  Text(
                                    "${controller.completeBookingdataList[index].date ?? ''}",
                                    style: TextStyle(
                                        color: Theme.of(Get.context!)
                                            .colorScheme
                                            .error,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: .5.h,
                                  ),
                                  SizedBox(
                                    width: 60.w,
                                    child: Text(
                                      "${controller.completeBookingdataList[index].userLocation?.streetNo ?? ''}, ${controller.completeBookingdataList[index].userLocation?.streetName ?? ''}, ${controller.completeBookingdataList[index].userLocation?.location ?? ''}",
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
                                        "${controller.completeBookingdataList[index].distance != null ? double.parse(controller.completeBookingdataList[index].distance.toString()).toStringAsFixed(2) : 'N/A'} ${"km".tr}",
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
                                height: 2.h,
                              ),
                              Flexible(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${controller.completeBookingdataList[index].subcategory?.price ?? 'N/A'} IQD",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(Get.context!)
                                              .colorScheme
                                              .onTertiary,
                                          fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Container(
                                        padding: EdgeInsets.all(10.sp),
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onTertiary,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Text(
                                          content.toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .errorContainer,
                                              fontSize: 12),
                                        )),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Icon(Icons.watch_later_rounded),
                                  Text(
                                      "${"Time Slot".tr} :  ${controller.completeBookingdataList[index].fromTime} - ${controller.completeBookingdataList[index].toTime}")
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
