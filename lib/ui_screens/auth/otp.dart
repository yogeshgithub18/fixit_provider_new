import 'dart:async';

import 'package:fixit/common/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Routes/app_routes.dart';
import '../../common/bordered_button.dart';
import '../app_header.dart';

class Otp extends StatefulWidget {
  const Otp({Key  ?key,}) : super(key: key);

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
 late TextEditingController otpController;
  @override
  void initState() {
    super.initState();
    otpController = TextEditingController();
    init();
  }
 int _counter = 0;
 late Timer _timer;
 bool resendStatus = false;

 @override

 String getFormattedTimer() {
   return _counter.toString().padLeft(2, '0');
 }

 void init() {
   _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
     setState(() {
       _counter++;
       if (_counter >=49) {
         _timer.cancel();
         resendStatus = true;
       }
     });
   });
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(5.h),
          child: const AppHeader(title:"", showBackIcon:true,isBackIcon: true,)),
      resizeToAvoidBottomInset: false,
      body:Column(
        children: [
          Text(
            "OTP".tr,
            style: TextStyle(fontSize: 25,color: Theme.of(Get.context!).colorScheme.tertiary,),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 1.h,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Please enter 6-digit verification \n code that was send to your Mobile Number \"xxxxxx0125\"".tr,
                style:
                TextStyle(fontSize: 18, color: Theme.of(Get.context!).colorScheme.onTertiary),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0,right: 50,top: 10,bottom: 10),
            child: PinCodeTextField(
              controller: otpController,
              textStyle: const TextStyle(color: ColorConstants.primaryColor),
              length: 4,
              autoFocus: true,
              keyboardType: TextInputType.number,
              obscureText: false,
              cursorColor:Theme.of(Get.context!).colorScheme.error,
              animationType: AnimationType.fade,
              autovalidateMode:otpController.text.length == 4 ? AutovalidateMode.always : AutovalidateMode.disabled,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.circle,
                borderRadius: BorderRadius.circular(20),
                fieldHeight: 7.h,
                inactiveColor: Theme.of(Get.context!).colorScheme.primaryContainer,
                fieldWidth: 7.h,
                borderWidth: 1,
                disabledColor: Theme.of(Get.context!).colorScheme.primaryContainer,
                activeColor: ColorConstants.primaryColor,
                selectedFillColor:Theme.of(Get.context!).colorScheme.onPrimaryContainer,
                inactiveFillColor:Theme.of(Get.context!).colorScheme.primaryContainer,
                selectedColor: ColorConstants.primaryColor,
                activeFillColor: Theme.of(Get.context!).colorScheme.onPrimaryContainer,
                errorBorderColor: Colors.red,
              ),
              animationDuration: const Duration(milliseconds: 300),
              enableActiveFill: true,
              onCompleted: (v) {
                debugPrint("Completed");
              },
              validator: (otp) {
                return null;
              },
              onChanged: (value) {
                debugPrint(value);
              },
              beforeTextPaste: (text) {
                return true;
              },
              appContext: context,
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          GestureDetector(onTap:() =>Get.toNamed(Routes.setLocation),
              child: BorderedButton(width:60.0.w,text: "SUBMIT".tr,isReversed: true,)),
          SizedBox(
            height: 3.h,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "OTP Expire Within:${getFormattedTimer()}",///todo
                style:
                TextStyle(fontSize: 18, color: Theme.of(Get.context!).colorScheme.onTertiary),
                textAlign: TextAlign.center,
              ),
            ),
          ),
           Flexible(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () {
                  if (resendStatus) {
                    resendStatus = false;
                    _counter = 0;
                    init();
                  }
                },
                child: Text(
                  "Resend OTP ?".tr,
                  style:
                  const TextStyle(fontSize: 16, color: ColorConstants.primaryColor,fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
