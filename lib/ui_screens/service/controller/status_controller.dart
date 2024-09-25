import 'package:fixit/backend/api_end_points.dart';
import 'package:fixit/backend/base_api.dart';
import 'package:fixit/ui_screens/bottomSubPages/controller/my_bookings_controller.dart';
import 'package:get/get.dart';

class StatusController extends GetxController {
  var selectedStatus = 0;
  List<Status> list = [
    Status("On The Way".tr, 1),
    Status("Reached".tr, 2),
    Status("Service Complete".tr, 4),
  ];
  Future <void> changeRequestStatus(requestID, status) async {
    Map<String, dynamic> params = {
      'service_request_id'.tr: requestID,
      'status'.tr: status
    };
    await BaseAPI().post(url: ApiEndPoints().changeRequestStatus, data: params)
        .then((value) {
      if (value?.statusCode == 200) {
        print('REQUEST STATUS CHANGE');
        Get.find<MyBookingsController>().getActiveBookingsData();
      }
    });
    update();
  }
}

class Status {
  String title;
  int id;
  Status(this.title, this.id);
}
