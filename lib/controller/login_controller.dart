import 'package:fixit/Routes/app_routes.dart';
import 'package:fixit/backend/api_end_points.dart';
import 'package:fixit/backend/base_api.dart';
import 'package:fixit/backend/modal/otp_response.dart';
import 'package:fixit/common/base_overlays.dart';
import 'package:fixit/main.dart';
import 'package:fixit/storage/base_shared_preference.dart';
import 'package:fixit/storage/sp_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  verifyByEmail() async {
    // if (deviceToken == '' || deviceToken.isEmpty || deviceToken == '1234') {
    //   deviceToken = await FirebaseMessaging.instance.getToken() ?? '1234';
    // }
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    Map<String, dynamic> dataEmail = {
      "email": email.text.trim().toString(),
      "password": password.text.trim().toString(),
      'fcm_token': deviceToken,
      'role_type': 2
    };
    await BaseAPI().post(url: ApiEndPoints().login, data: dataEmail).then((value) {
      OtpResponse response = OtpResponse.fromJson(value?.data);
      if (value?.statusCode == 200) {
        BaseSharedPreference().setBool(SpKeys().isLoggedIn, true);
        BaseSharedPreference().setString(SpKeys().apiToken, response.data?.token ?? "");
        BaseSharedPreference().setString(SpKeys().userName, response.data?.name ?? "");
        BaseSharedPreference().setString(SpKeys().userProfile, response.data?.image ?? "");
        BaseSharedPreference().setInt(SpKeys().userId, response.data?.id ?? "");
        BaseSharedPreference().setInt(SpKeys().isAvailable, response.data?.isAvailable ?? "");
        BaseSharedPreference().setString(SpKeys().isNotification, response.data?.isNotification ?? "");
        BaseSharedPreference().setJson(SpKeys().user,response.data??{});
        if ((response.message ?? "").isNotEmpty) {
          BaseOverlays().showSnackBar(message: response.message!, title: "Success".tr);
        }
        Get.offAllNamed(Routes.home);
      } else {
        BaseOverlays().showSnackBar(message: response.message ?? "", title: "Error".tr);
      }
    });
  }
}
