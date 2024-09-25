import 'package:fixit/backend/api_end_points.dart';
import 'package:fixit/backend/base_api.dart';
import 'package:fixit/backend/modal/notification_data_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../common/base_overlays.dart';
import '../main.dart';
import '../ui_screens/bottomSubPages/controller/dashboardController.dart';
import '../ui_screens/bottomSubPages/controller/my_bookings_controller.dart';

class NotificationController extends GetxController {
  RxList<NotificationData> notificationdataList = <NotificationData>[].obs;
  RxBool isLoader=false.obs;
  final now = DateTime.now();
  RxInt page = 1.obs;
  final RefreshController refreshController = RefreshController(initialRefresh: false);

  getNotificationData({String ? refreshType})async {
    bool showLoader=false;
    if (refreshType == 'refresh' || refreshType == null) {
      notificationdataList.clear();
      refreshController.loadComplete();
      page.value = 1;
      isLoader.value=true;
      showLoader=true;
    } else if (refreshType == 'load') {
      page.value++;
    }
    Map<String,dynamic> param={
      "limit":apiItemLimit,
      "page":page.value.toString(),};
    await BaseAPI()
        .get(url: ApiEndPoints().getNotifications, queryParameters: param,showLoader: false)
        .then((value) {
      isLoader.value=false;
      if (value?.statusCode == 200) {
        NotificationDataModel response=NotificationDataModel.fromJson(value?.data);
        if(response.status??false){
          if(refreshType == 'refresh'){
            notificationdataList.clear();
            refreshController.loadComplete();
            refreshController.refreshCompleted();
            Get.find<MyBookingsController>().getNotificationCount();
          }else if((response.data??[]).isEmpty && refreshType == 'load'){
            refreshController.loadNoData();
          }
          else if(refreshType == 'load'){
            refreshController.loadComplete();
          }
          notificationdataList.addAll(response.data??[]);
        }else{
          BaseOverlays().showSnackBar(message:response.message??'',title: 'Error');
        }
      }
    });
  }

  readNotification({required String id}) async {
    Map<String, dynamic> params = {'status': 1,"notification_id":id};
    await BaseAPI()
        .post(url: ApiEndPoints().markNotifications, data: params)
        .then((value) {
      if (value?.statusCode == 200) {
        getNotificationData();

      }
    });
    update();
  }

  deleteNotification(id) async {
    Map<String, dynamic> params = {'notification_id': id};
    await BaseAPI()
        .post(url: ApiEndPoints().deleteNotifications,
            data: params,
            showLoader: false)
        .then((value) {
      if (value?.statusCode == 200) {
        int index =
            notificationdataList.indexWhere((element) => element.id == id);
        notificationdataList.removeAt(index);
      }
    });
    update();
  }

  markNotification(status) async {
    Map<String, dynamic> params = {'status': status};
    await BaseAPI()
        .post(url: ApiEndPoints().markNotifications, data: params)
        .then((value) {
      if (value?.statusCode == 200) {
        if (status == 3) {
          notificationdataList.clear();
        } else {
          notificationdataList.clear();
          notificationdataList.addAll(NotificationDataModel.fromJson(value?.data).data ?? []);
        }
        Get.find<MyBookingsController>().getNotificationCount();
      }
    });
    update();
  }

  String getDate(date) {
    final difference = now.difference(date);

    final formatter = DateFormat('yMd');
    final formattedDate = formatter.format(date);

    final timeAgo = _timeAgo(difference);
    print('$formattedDate, $timeAgo');
    return timeAgo;
  }

  String _timeAgo(Duration duration) {
    if (duration.inDays >= 365) {
      final years = (duration.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    } else if (duration.inDays >= 30) {
      final months = (duration.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else if (duration.inDays >= 1) {
      return '${duration.inDays} ${duration.inDays == 1 ? 'day' : 'days'} ago';
    } else if (duration.inHours >= 1) {
      return '${duration.inHours} ${duration.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (duration.inMinutes >= 1) {
      return '${duration.inMinutes} ${duration.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'just now';
    }
  }
}
