import 'package:fixit/Routes/app_routes.dart';
import 'package:fixit/backend/api_end_points.dart';
import 'package:fixit/backend/base_api.dart';
import 'package:fixit/storage/base_shared_preference.dart';
import 'package:fixit/storage/sp_keys.dart';
import 'package:get/get.dart';

import '../../../common/base_overlays.dart';

class SettingsController extends GetxController {
  RxBool isNotificationSend = false.obs;


  logout() async {
    await BaseAPI().get(url: 'user/logout').then((value) {
      if (value?.statusCode == 200) {
        BaseOverlays()
            .showSnackBar(message: "LogOut Successfully".tr, title: "Success".tr);
        Get.offAllNamed(Routes.loginScreen);
        BaseSharedPreference().clearLoginSession();
      } else {
        BaseOverlays()
            .showSnackBar(message: "Something Went Wrong!!".tr, title: "Error".tr);
      }
    });
    update();
  }

  notificationSetting() async {
    Map<String, dynamic> data = {
      "is_notification": isNotificationSend.value ? 1 : 0,
    };
    await BaseAPI()
        .post(url: ApiEndPoints().notificationSetting, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        BaseSharedPreference().setString(SpKeys().isNotification, isNotificationSend.value ? "1" : "0");
        BaseOverlays()
            .showSnackBar(message: "Setting Updated".tr, title: "Success".tr);
      } else {
        BaseOverlays()
            .showSnackBar(message: "Something Went Wrong!!".tr, title: "Error".tr);
      }
    });
    update();
  }
}
