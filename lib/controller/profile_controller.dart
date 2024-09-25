import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit/backend/api_end_points.dart';
import 'package:fixit/backend/base_api.dart';
import 'package:fixit/backend/modal/profile_response.dart';
import 'package:fixit/backend/modal/profile_update_response.dart';
import 'package:fixit/storage/base_shared_preference.dart';
import 'package:fixit/storage/sp_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:url_launcher/url_launcher.dart';

import '../../../common/base_overlays.dart';

class ProfileController extends GetxController {
  ProfileData data = ProfileData();

     RxString helpEmail =' help@gmail.com'.obs;
     RxString helpNumber ='971-2-1234567'.obs;

  TextEditingController fullName = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController email = TextEditingController();
  String gender = "male";
  File? selectedFile = File("");
  String imageData = '';
  String profilePath = '';

  getProfile() async {
    await BaseAPI().get(url: ApiEndPoints().profile,showLoader: false).then((value) {
      if (value?.statusCode == 200) {
        ProfileResponse response = ProfileResponse.fromJson(value?.data);
        data = response.data!;
        BaseSharedPreference().setString(SpKeys().userName, response.data?.name ?? "");
        BaseSharedPreference().setString(SpKeys().userProfile, response.data?.image ?? "");
        BaseSharedPreference().setInt(SpKeys().isAvailable, response.data?.isAvailable??0);
      }
    });
    update();
  }

  setData() {
    fullName.text = data.name!;
    mobileNo.text = data.phone!;
    email.text = data.email!;
    gender = data.gender ?? "male";
    profilePath = data.image ?? "";
    update();
  }

  updateProfile() async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    dio.FormData data = dio.FormData.fromMap({
      "name": fullName.text.trim().toString(),
      "email": email.text.trim().toString(),
      "phone": mobileNo.text.trim().toString(),
      "gender": gender,
    });
    if ((selectedFile?.path ?? "").isNotEmpty) {
      data.files.add(MapEntry(
          "profile",
          await dio.MultipartFile.fromFile(selectedFile?.path ?? "",
              filename: selectedFile?.path.split("/").last ?? "")));
    }
    await BaseAPI()
        .post(url: ApiEndPoints().updateProfile, data: data)
        .then((value) {
      EditProfileResponse response = EditProfileResponse.fromJson(value?.data);
      if (value?.statusCode == 200) {
        BaseSharedPreference().setString(SpKeys().userProfile,response.data?.image);
        Get.back();
        if ((response.message ?? "").isNotEmpty) {
           BaseSharedPreference().setString(SpKeys().userProfile,response.data?.image);
           BaseOverlays().showSnackBar(message: response.message!, title: "Success".tr);
        }
      } else {
        BaseOverlays().showSnackBar(message: response.message ?? "", title: "Error".tr);
      }
    });
    update();
  }

  Future registerUser(String mobile) async{
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: '7784007251',
        timeout: Duration(seconds: 60),
        verificationCompleted: (credential){
        },
        verificationFailed: (VerificationFailed){
        },
        codeSent:(sentcode,id){
        },
        codeAutoRetrievalTimeout:(Timeout){
        }
    );
  }
  Future<void> launchPhoneDialer(String contactNumber) async {
    final Uri _phoneUri = Uri(
        scheme: "tel",
        path: contactNumber
    );
    try {
      if (await canLaunch(_phoneUri.toString()))
        await launch(_phoneUri.toString());
    } catch (error) {
      throw("Cannot dial".tr);
    }
  }

  Future<void> launchPhoneMail(String email) async {
    final url = 'mailto:$email';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

// Call the function with the email address
//   launchPhoneMail('help@gmail.com');

}
