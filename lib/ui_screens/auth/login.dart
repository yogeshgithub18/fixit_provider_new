import 'package:fixit/common/bordered_button.dart';
import 'package:fixit/common/color_constants.dart';
import 'package:fixit/common/utils.dart';
import 'package:fixit/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/base_overlays.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 50.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/images/mobileSelected.svg',
                height: 10.h,
                width: 10.w,
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                "Login".tr,
                style: TextStyle(
                    fontSize: 24.0,
                    color: Theme.of(Get.context!).colorScheme.tertiary),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                "Please enter login details".tr,
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(Get.context!).colorScheme.onTertiary),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 3.h,
              ),
              EmailLoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class EmailLoginForm extends StatefulWidget {
  @override
  State<EmailLoginForm> createState() => _EmailLoginFormState();
}

class _EmailLoginFormState extends State<EmailLoginForm> {
  bool isShow1 = true;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 5,),
                decoration: BoxDecoration(
                    color: Theme.of(Get.context!).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: EdgeInsets.only(left: 20.sp,right: 20.sp),
                  child: addEditText2(
                    controller.email,
                    "Email Address".tr,
                  ),
                )),
            SizedBox(height: 2.h),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                    color: Theme.of(Get.context!).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: EdgeInsets.only(left: 20.sp,right: 20.sp),
                  child: TextFormField(
                    cursorColor: ColorConstants.primaryColor,
                    keyboardType: TextInputType.multiline,
                    controller: controller.password,
                    obscureText: isShow1,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(fontSize: getNormalTextFontSIze()),
                    decoration: InputDecoration(
                        hintText: "Password".tr,
                        suffixIcon: GestureDetector(
                            onTap: (){
                              setState(() {
                                isShow1=!isShow1;
                              });
                            },
                            child: Icon(
                              isShow1? Icons.visibility_off : Icons.visibility, color: Theme.of(Get.context!).colorScheme.onTertiary,
                            )),
                        hintStyle: TextStyle(
                            color: Theme.of(Get.context!).colorScheme.error,
                            fontSize: getNormalTextFontSIze()),
                        border: InputBorder.none),
                  ),
                )),
            SizedBox(height: 2.h),
            GestureDetector(
                onTap: () {
                  if(controller.email.text.trim().isEmpty){
                    BaseOverlays().showSnackBar(message:"Please enter email".tr,title: "Error");
                  }else if(controller.password.text.trim().isEmpty){
                    BaseOverlays().showSnackBar(message:"Please enter password".tr,title: "Error");
                  }else{
                    controller.verifyByEmail();
                  }
                },
                child: BorderedButton(
                  width: 1,
                  text: "LOGIN".tr,
                  isReversed: true,
                ))
          ],
        ),
      );
    });
  }
}
