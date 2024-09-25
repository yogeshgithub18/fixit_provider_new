import 'package:fixit/backend/api_end_points.dart';
import 'package:fixit/backend/base_api.dart';
import 'package:fixit/backend/modal/notification_model.dart';
import 'package:fixit/common/base_overlays.dart';
import 'package:fixit/storage/base_shared_preference.dart';
import 'package:fixit/storage/sp_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../backend/modal/all_bookings_data_model.dart';
import '../../../main.dart';



class MyBookingsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxInt currentIndex = 0.obs;
  RxBool isAvailable = false.obs;
  RxInt notificationCount = 0.obs;
  RxList<Data> allBookingdataList = <Data>[].obs;
  RxList<Data> activeBookingdataList =<Data>[].obs;
  RxList<Data> completeBookingdataList = <Data>[].obs;
  late TextEditingController addOnAmountCtrl;
  late TextEditingController addOnReasonCtrl;
  String status = 'Service Started';
  RxInt page = 1.obs;
  final RefreshController refreshController = RefreshController(initialRefresh: false);

  statusSetting() async {
    Map<String, dynamic> data = {
      "is_available": isAvailable.value ? 1 : 0,
    };
    await BaseAPI().post(url: ApiEndPoints().serviceProviderstatus, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        BaseSharedPreference().setInt(SpKeys().isAvailable, isAvailable.value ? 1 : 0);
        BaseOverlays().showSnackBar(message: "Setting Updated".tr, title: "Success".tr);
      } else {
        BaseOverlays()
            .showSnackBar(message: "Something Went Wrong!!".tr, title: "Error".tr);
      }
    });
    update();
  }

  getAllBookingsData({String ? refreshType})async {
    bool showLoader=false;
    if (refreshType == 'refresh' || refreshType == null) {
      allBookingdataList.clear();
      refreshController.loadComplete();
      page.value = 1;
      showLoader=true;
    } else if (refreshType == 'load') {
      showLoader=false;
      page.value++;
    }
    Map<String, dynamic> params = {'is_available': isAvailable.value ? 1 : 0,
     "status":currentIndex.value,
      "limit":apiItemLimit,
      "page":page.value.toString(),};
     await BaseAPI()
        .get(url: ApiEndPoints().serviceProviderRequests, queryParameters: params,showLoader: showLoader)
        .then((value) {
       if (value?.statusCode == 200) {
         AllBookingsDataModel allBookingsDataModel=AllBookingsDataModel.fromJson(value?.data);
         if (refreshType == 'refresh') {
           allBookingdataList.clear();
           refreshController.loadComplete();
           refreshController.refreshCompleted();
         } else if ((allBookingsDataModel.data ?? []).isEmpty &&
             refreshType == 'load') {
           refreshController.loadNoData();
         }
         else if (refreshType == 'load') {
           refreshController.loadComplete();
         }
         allBookingdataList.addAll(allBookingsDataModel.data ?? []);
       }
    });
  }

  getActiveBookingsData() async {
    Map<String, dynamic> params = {};
    await BaseAPI()
        .get(url: ApiEndPoints().activeBookings, queryParameters: params)
        .then((value) {
      activeBookingdataList.clear();
      if (value?.statusCode == 200) {
        activeBookingdataList.addAll(AllBookingsDataModel.fromJson(value?.data).data ?? []);
      }
    });
    update();
  }

  getCompleteBookingsData({String ? refreshType})async {
    bool showLoader=false;
    if (refreshType == 'refresh' || refreshType == null) {
      completeBookingdataList.clear();
      refreshController.loadComplete();
      page.value = 1;
      showLoader=true;
    } else if (refreshType == 'load') {
      showLoader=false;
      page.value++;
    }
    Map<String, dynamic> params = {"limit":apiItemLimit,
      "page":page.value.toString(),};
    await BaseAPI()
        .get(url: ApiEndPoints().completeBookings, queryParameters: params,showLoader: showLoader)
        .then((value) {
      if (value?.statusCode == 200) {
        AllBookingsDataModel allBookingsDataModel=AllBookingsDataModel.fromJson(value?.data);
        if (refreshType == 'refresh') {
          completeBookingdataList.clear();
          refreshController.loadComplete();
          refreshController.refreshCompleted();
        } else if ((allBookingsDataModel.data ?? []).isEmpty &&
            refreshType == 'load') {
          refreshController.loadNoData();
        }
        else if (refreshType == 'load') {
          refreshController.loadComplete();
        }
        completeBookingdataList.addAll(allBookingsDataModel.data ?? []);
      }
    });
  }

  Future<void> acceptBookingRequest(requestID) async {
    Map<String, dynamic> params = {'service_request_id': requestID};
    await BaseAPI()
        .post(url: ApiEndPoints().acceptServiceRequests, data: params)
        .then((value) {

          print(value!.data);
      if (value?.statusCode == 200) {
        getActiveBookingsData();
      } else if (value?.statusCode == 200) {
        getActiveBookingsData();
      }
      print("STATUS CODE:- ${value?.statusCode}");
    });

    update();
  }

  Future<void> rejectBookingRequest(requestID) async {
    Map<String, dynamic> params = {'service_request_id': requestID};
    await BaseAPI().post(url: ApiEndPoints().rejectServiceRequestsProvider, data: params)
        .then((value) {
          print(value!.data);
      if (value?.statusCode == 200) {
        getActiveBookingsData();
      } else if (value?.statusCode == 200) {
        getActiveBookingsData();
      }
      print("STATUS CODE:- ${value?.statusCode}");
    });

    update();
  }

  Future<void> cancelServiceRequest(requestID) async {
    Map<String, dynamic> params = {'service_request_id': requestID};
    await BaseAPI()
        .post(url: ApiEndPoints().cancelServiceRequests, data: params)
        .then((value) {
      if (value?.statusCode == 200) {
        getActiveBookingsData();
      } else if (value?.statusCode == 200) {
        getActiveBookingsData();
      }
      print("STATUS CODE:- ${value?.statusCode}");
    });

    update();
  }

  getNotificationCount() async {
    await BaseAPI().get(url: ApiEndPoints().notificationCount,showLoader: false).then((value) {
      if (value?.statusCode == 200) {
        notificationCount.value= Notification_count.fromJson(value?.data).data?[0].count??0;
      }
    });
  }

  Future<void> startServiceRequests(requestID) async {
    Map<String, dynamic> params = {'service_request_id': requestID};
    await BaseAPI()
        .post(url: ApiEndPoints().startServiceRequests, data: params)
        .then((value) {
      if (value?.statusCode == 200) {
        getActiveBookingsData();
      } else if (value?.statusCode == 200) {
        getActiveBookingsData();
      }
      print("STATUS CODE:- ${value?.statusCode}");
    });

    update();
  }

  Future<void> sendProviderLocation(lat,long) async {
    Map<String, dynamic> params = {
      'latitude': lat,
      'longitude': long,
    };
    await BaseAPI()
        .post(url: ApiEndPoints().locationServices, data: params,showLoader: false)
        .then((value) {
      if (value?.statusCode == 200) {

      }
    });
  }

  addOnServices(requestID) async {
    Map<String, dynamic> params = {
      'service_request_id': requestID,
      'addon_price': addOnAmountCtrl.text.trim().toString(),
      'addon_price_reason': addOnReasonCtrl.text.trim().toString()
    };
    await BaseAPI()
        .post(url: ApiEndPoints().addOnServices, data: params)
        .then((value) {
      if (value?.statusCode == 200) {
        Get.back();
        getActiveBookingsData();
        addOnAmountCtrl.clear();
        addOnReasonCtrl.clear();
      }
    });
    update();
  }

  String formatDateString(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime.toLocal());
    return formattedDate;
  }

  String formatTimeString(String timeString) {
    DateTime dateTime = DateTime.parse(timeString);
    String formattedTime = DateFormat('hh:mma').format(dateTime.toLocal());
    return formattedTime;
  }

  String serviceStatus(int statusid) {
    if (statusid == 1) {
      status = 'On The Way'.tr;
    } else if (statusid == 2) {
      status = 'Reached'.tr;
    } else if (statusid == 4) {
      status = 'Service Complete'.tr;
    }
    // update();

    return status;
  }

  getAvailablity() async {
    int available = await BaseSharedPreference().getInt(SpKeys().isAvailable);
    if (available == 1) {
      isAvailable.value = true;
    } else if (available == 0) {
      isAvailable.value = false;
    }
    update();
    print("AVAILABLITY:- ${available}");
  }

  MyBookingsController() {
    addOnAmountCtrl = TextEditingController();
    addOnReasonCtrl = TextEditingController();
    getAvailablity();
  }
}

class Status{
  String title;
  int id;
  Status(this.title, this.id);
}
