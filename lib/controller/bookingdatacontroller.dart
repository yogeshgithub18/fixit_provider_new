import 'package:fixit/backend/api_end_points.dart';
import 'package:fixit/backend/modal/all_bookings_data_model.dart';
import 'package:fixit/backend/modal/booking_detail_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../backend/base_api.dart';

class AllBookingsController extends GetxController {
  RxList<Data> allBookingdataList = <Data>[].obs;
  BookingDetailData? bookingDetailData;
  final ratingFormkey = GlobalKey<FormState>();
  var rating = 1.0;
  RxInt selectedIndex=0.obs;
  late TextEditingController commentCtrl;

  getAllBookingsData() async {
    allBookingdataList.clear();
    int status=selectedIndex.value==0?0:selectedIndex.value==1?4:selectedIndex.value==2?1:selectedIndex.value==3?2:3;
    Map<String, dynamic> params = {'status': status};
    await BaseAPI().get(url: ApiEndPoints().allBookings, queryParameters: params).then((value) {
      if (value?.statusCode == 200) {
        allBookingdataList.value= AllBookingsDataModel.fromJson(value?.data).data ?? [];
      }
    });
    // update();
  }

  // List<Data> acceptedBookingList = [];
  // getAcceptedBookingData(status) async {
  //   allBookingdataList.clear();
  //   Map<String, dynamic> params = {'status': status};
  //   await BaseAPI()
  //       .get(url: ApiEndPoints().allBookings, queryParameters: params)
  //       .then((value) {
  //     if (value?.statusCode == 200) {
  //       allBookingdataList=AllBookingsDataModel.fromJson(value?.data).data ?? [];
  //     }
  //   });
  //   update();
  // }

  getActiveBookingsData(status) async {
    Map<String, dynamic> params = {'status': status};
    await BaseAPI()
        .get(url: ApiEndPoints().allBookings, queryParameters: params)
        .then((value) {
      if (value?.statusCode == 200) {
        allBookingdataList.clear();
        allBookingdataList
            .addAll(AllBookingsDataModel.fromJson(value?.data).data ?? []);
      }
    });
    update();
  }

  getBookingDetailData(id) async {
    bookingDetailData=BookingDetailData();
    Map<String, dynamic> params = {'service_request_id': id};
    await BaseAPI()
        .post(url: ApiEndPoints().bookingDetail, data: params)
        .then((value) {
      if (value?.statusCode == 200) {
        bookingDetailData = BookingDetailDataModel.fromJson(value?.data).data;
      }
    });
    update();
  }

  confirmBookingAPI(id) async {
    Map<String, dynamic> params = {'service_request_id': id};
    await BaseAPI()
        .post(url: ApiEndPoints().confirmBooking, data: params)
        .then((value) {
      if (value?.statusCode == 200) {
        bookingDetailData = BookingDetailDataModel.fromJson(value?.data).data;
      }
    });
    update();
  }
  cancelBookingAPI(id) async {
    Map<String, dynamic> params = {'service_request_id': id};
    await BaseAPI()
        .post(url: ApiEndPoints().cancelBooking, data: params)
        .then((value) {
      if (value?.statusCode == 200) {
        bookingDetailData = BookingDetailDataModel.fromJson(value?.data).data;
      }
    });
    update();
  }


  giveRating(id) async {
    Map<String, dynamic> params = {
      'service_request_id': id,
      'rating': rating,
      'rating_comment': commentCtrl.text.trim().toString()
    };
    await BaseAPI()
        .post(url: ApiEndPoints().giveRating, data: params)
        .then((value) {
      if (value?.statusCode == 200) {
        // BaseOverlays()
        //     .showSnackBar(message: response.message!, title: "Success");
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

  AllBookingsController() {
    commentCtrl = TextEditingController();
  }
}
