import 'package:fixit/common/bordered_button.dart';
import 'package:fixit/ui_screens/home/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Routes/app_routes.dart';
import '../../common/color_constants.dart';

class SetLocation extends StatefulWidget {
  final bool? FromHome;
  const SetLocation({super.key,this.FromHome=false});

  @override
  State<SetLocation> createState() => _SetLocationState();
}

class _SetLocationState extends State<SetLocation> {
  HomeController controller=Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:EdgeInsets.only(top:25.sp),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding:EdgeInsets.only(left:20.sp,right:20.sp,bottom:10.sp),
                child: Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color:Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Theme.of(Get.context!).colorScheme.onTertiary),
                    decoration: InputDecoration(
                        prefixIcon:Icon(Icons.search,color: ColorConstants.primaryColor,),
                        border:InputBorder.none,
                        hintText: 'Search Location'.tr,
                        hintStyle: TextStyle(color:Theme.of(context).colorScheme.error,
                        )
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(1),
                child: Stack(
                  children:[
                  Container(
                    height: 50.h,
                      width: 90.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Image.asset("assets/images/map_images.png",fit: BoxFit.fill,)),
                    Positioned(
                         //top: 0,
                        bottom:30,
                        left: 20,
                        right: 20,
                        child:Center(
                          child: Container(
                      height:5.h,
                      width: 60.w,
                      decoration: BoxDecoration(
                        color:Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(20),
                      ),
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/images/currntLoc.svg",color: ColorConstants.primaryColor,),
                            SizedBox(width: 2.w,),
                            Text("Current Location".tr,style:TextStyle(color: ColorConstants.primaryColor),),
                            SizedBox(width:2.w,),
                            SvgPicture.asset("assets/images/long_arrow.svg",color: ColorConstants.primaryColor,),
                          ],
                      ),
                    ),
                        )),
                   ]
                ),
              ),SizedBox(
                height: 2.h,
              ),
              Container(
                height: 6.h,
                decoration: BoxDecoration(
                  color:Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(1),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child:Padding(
                    padding:EdgeInsets.only(left:25.sp),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/images/locPin.svg",color:Theme.of(context).colorScheme.onTertiary,),
                        SizedBox(width: 1.w,),
                        Text("123, location is your ,iraq".tr,style: TextStyle( color:Theme.of(context).colorScheme.onTertiary,),)
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 2.h,),
              GestureDetector(
                onTap:()=>Get.toNamed(Routes.addLocation),
                  child: BorderedButton(width:1, text:"Add Location".tr.toUpperCase())),
              SizedBox(height: 2.h,),
              GestureDetector(
                  onTap:(){
                    if(widget.FromHome??false){
                      controller.currentIndex.value = 2;
                    }else {
                      Get.toNamed(Routes.home);
                    }
                  },
                  child: BorderedButton(width:1, text:"Get Started".tr.toUpperCase(),isReversed: true,))
            ],
          ),
        ),
      )
    );
  }
}
