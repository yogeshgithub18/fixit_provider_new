
import 'package:fixit/backend/modal/otp_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../storage/base_shared_preference.dart';
import '../storage/sp_keys.dart';


class BaseController extends GetxController{
  Rx<Data> ? user=Data().obs;
  RxInt count=0.obs;
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final bool isLoggedIn = await BaseSharedPreference().getBool(SpKeys().isLoggedIn)??false;
      if (isLoggedIn) {
        Map<String,dynamic> data = await BaseSharedPreference().getJson(SpKeys().user);
        user?.value= Data.fromJson(data);
        print("data=--->${user?.value.name}");
        print("data image=--->${user?.value.image}");
        //getNotifications();
      }
    });
  }

  // Future<void>getNotifications()async{
  //   String userId=Get.find<BaseController>().user?.sId??'';
  //   await BaseAPI().get(url:ApiEndPoints.getNotifications+userId).then((value) {
  //     if(value!=null){
  //       NotificationModel response=NotificationModel.fromJson(value.data);
  //       if(response.success??false){
  //         print("count---${response.data?.unReadCount}");
  //         count.value=response.data?.unReadCount??0;
  //       }
  //     }
  //   });
  // }
}
