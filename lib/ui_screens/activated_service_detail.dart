import 'package:fixit/backend/modal/all_bookings_data_model.dart';
import 'package:fixit/ui_screens/service/ad_on_service.dart';
import 'package:fixit/ui_screens/service/change_status.dart';
import 'package:fixit/ui_screens/service/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../common/base_image_network.dart';
import '../common/bordered_button.dart';
import '../common/color_constants.dart';
import '../storage/base_shared_preference.dart';
import '../storage/sp_keys.dart';
import 'app_header.dart';
import 'bottomSubPages/controller/my_bookings_controller.dart';
import 'locations/GoogleMap_Screen.dart';

// ignore: must_be_immutable
class ActivatedServiceDetail extends StatefulWidget {
  Data bookingData;
  ActivatedServiceDetail({Key? key, required this.bookingData}) : super(key: key);

  @override
  State<ActivatedServiceDetail> createState() => _ActivatedServiceDetailState();
}

class _ActivatedServiceDetailState extends State<ActivatedServiceDetail> {
  MyBookingsController controller = Get.find<MyBookingsController>();

  String userProfile = "";
  String userName = "";

  @override
  void initState() {
    init();
    print("wegitdata---${widget.bookingData}" );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(5.h),
          child:  AppHeader(
            title: "Service Detail".tr,
            showBackIcon: true,
            isBackIcon: true,
          )),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(top: 15.sp),
          child: Column(
            children: [
              Container(
                margin:
                EdgeInsets.only(left: 15.sp, right: 15.sp, bottom: 10.sp),
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
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.bookingData.category
                                    ?.name ??
                                    '',
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
                              Text(
                                "${widget.bookingData.userLocation?.streetNo ?? ''}, ${widget.bookingData.userLocation?.streetName ?? ''}, ${widget.bookingData.userLocation?.location ?? ''}",
                                style: TextStyle(
                                    color: Theme.of(Get.context!)
                                        .colorScheme
                                        .onTertiary,
                                    fontSize: 16),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset("assets/images/locator.svg", color: Theme.of(Get.context!)
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
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${widget.bookingData.subcategory?.price ?? 'N/A'} IQD",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(Get.context!)
                                      .colorScheme
                                      .onTertiary,
                                  fontSize: 20),
                            ),
                          ],
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
                          Text("${'Time Slot'.tr}:${widget.bookingData.fromTime} - ${widget.bookingData.toTime}")///todo
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.sp),
                child: Container(
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: Theme.of(Get.context!)
                        .colorScheme
                        .primaryContainer ,
                    borderRadius: BorderRadius.circular(5),
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
                                      fit: BoxFit.fill, link: userProfile)),
                              SizedBox(
                                width: 2.w,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userName ?? '',
                                    style:  TextStyle(
                                        color:
                                        Theme.of(Get.context!)
                                            .colorScheme
                                            .onTertiary,
                                        fontSize: 16),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(12.sp),
                              child: Text(
                                controller.serviceStatus(widget.bookingData
                                    .serviceProviderStatus ??
                                    0),
                                style: TextStyle(
                                    color: Theme.of(Get.context!)
                                        .colorScheme
                                        .onTertiary,
                                    fontSize: 14),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
          // Padding(
          //   padding: const EdgeInsets.all(20.0),
          //   child: ClipRRect(
          //     borderRadius: BorderRadiusDirectional.all(Radius.circular(20)),
          //     child: Align(
          //         alignment: Alignment.center,
          //         child: SizedBox(
          //           height: 30,
          //           child: Row(
          //             crossAxisAlignment: CrossAxisAlignment.stretch,
          //             children: [
          //               Expanded(
          //                   flex: 33,
          //                   child: Container(
          //                     color:(widget.bookingData.serviceProviderStatus==1||widget.bookingData.serviceProviderStatus==2||widget.bookingData.serviceProviderStatus==4)? ColorConstants.primaryColor:Colors.white,
          //                     child: const Align(
          //                         alignment: Alignment.center,
          //                       child: Text('On the Way',style: TextStyle(color: Colors.white)),
          //                        ),
          //                   )),
          //               const VerticalDivider(
          //                 width: 1,
          //                 color: Colors.white,
          //               ),
          //               Expanded(
          //                   flex: 33,
          //                   child: Container(
          //                     color:(widget.bookingData.serviceProviderStatus==2||widget.bookingData.serviceProviderStatus==4)? ColorConstants.primaryColor:Colors.white,
          //                     child: const Align(
          //                         alignment: Alignment.center,
          //                       child: Text('Reached',style: TextStyle(color: Colors.white)),
          //                         ),
          //                   )),
          //               const VerticalDivider(
          //                 width: 1,
          //                 color: Colors.white,
          //               ),
          //               Expanded(
          //                   flex: 33,
          //                   child: Container(
          //                     color: widget.bookingData.serviceProviderStatus==4? ColorConstants.primaryColor:Colors.white,
          //                     child: const Align(
          //                         alignment: Alignment.center,
          //                       child: Text('Complete',style: TextStyle(color: Colors.white)),
          //                       ),
          //                   )),
          //             ],
          //           ),
          //         )),
          //   ),
          // ),
          //     SizedBox(
          //       height: 2.h,
          //     ),
              GestureDetector(
                onTap: () async{
                 int ? result= await Get.to(ChangeStatus(
                  serviceID: widget.bookingData.id!,
                  status: widget.bookingData.serviceProviderStatus!,
                ));
                 print("result---->>>$result");
                 if(result!=null){
                   widget.bookingData.serviceProviderStatus=result;
                   setState(() {

                   });
                  }
                  },
                child: BorderedButton(
                    width: 1,
                    isReversed: true,
                    text: "Update Status".tr.toUpperCase()),
              ),
              SizedBox(
                height: 2.h,
              ),
              GestureDetector(
                  onTap: () {
                    // openMapsSheet(context);
                    // double latitude = 37.7749; // Replace with your desired latitude
                    // double longitude = -122.4194; // Replace with your desired longitude
                    // final url = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
                    //
                    // if (await canLaunchUrl(Uri.parse(url))) {
                    // await launchUrl(Uri.parse(url));
                    // } else {
                    // throw 'Could not launch Google Maps';
                    // }
                    print("widget.bookingData.userId!-------${widget.bookingData.userLocation?.latitude}");
                    print("widget.bookingData.userId!-------${widget.bookingData.userLocation?.longitude}");
                    MapUtils.openMap(double.parse(widget.bookingData.userLocation!.latitude!),double.parse(widget.bookingData.userLocation!.longitude!));
                  },
                  child: BorderedButton(
                      width: 1, text: "View On Map".tr.toUpperCase())),
              SizedBox(
                height: 2.h,
              ),
              GestureDetector(
                  onTap: () {
                      Get.to( ChatScreen(id:int.parse(widget.bookingData.userId!),name:widget.bookingData.user?.name,image: widget.bookingData.user?.image ,isSend:true,));
                  },
                  child: BorderedButton(
                    width: 1,
                    text: "Chat".tr.toUpperCase(),
                    isReversed: true,
                    icon: "assets/images/chat_icon.svg",
                  )),
              SizedBox(
                height: 2.h,
              ),
              GestureDetector(
                  onTap: () => Get.to(AddOnService(
                    serviceId: widget.bookingData.id!,
                  )),
                  child: BorderedButton(
                      width: 1, text: "AddOn Service".tr.toUpperCase())),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
  // openMapsSheet(BuildContext context) async {
  //   try {
  //     final coords = Coords(37.759392, -122.5107336);
  //     final title = "Ocean Beach";
  //     final availableMaps = await MapLauncher.installedMaps;
  //
  //     showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return SafeArea(
  //           child: SingleChildScrollView(
  //             child: Container(
  //               child: Wrap(
  //                 children: <Widget>[
  //                   for (var map in availableMaps)
  //                     ListTile(
  //                       onTap: () => map.showMarker(
  //                         coords: coords,
  //                         title: title,
  //                       ),
  //                       title: Text(map.mapName),
  //                       leading: SvgPicture.asset(
  //                         map.icon,
  //                         height: 30.0,
  //                         width: 30.0,
  //                       ),
  //                     ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     );
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  Future<void> init() async {
    userName = await BaseSharedPreference().getString(SpKeys().userName);
    userProfile = await BaseSharedPreference().getString(SpKeys().userProfile);
    setState(() {});
  }
}
