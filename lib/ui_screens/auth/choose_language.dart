import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Routes/app_routes.dart';
import '../../common/bordered_button.dart';
import 'choose_language_controller.dart';

class ChooseLanguage extends StatefulWidget {
final String pageName;
  const ChooseLanguage({super.key, required this.pageName,});

  @override
  State<ChooseLanguage> createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {
  ChooseLanguageController controller=Get.put(ChooseLanguageController());
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment:MainAxisAlignment.center,
           children: [
             Center(
               child: Text(
                 "Choose Language".tr,
                 style: TextStyle(
                     fontSize: 24,
                     color: Theme.of(context).colorScheme.onTertiary),
               ),
             ),
              SizedBox(
                height: 5.h,
              ),
             InkWell(
               onTap: () {
                 controller.selectedLanguage.value='en';
               },
               child: Container(
                 decoration: BoxDecoration(
                     color: Theme.of(context).colorScheme.primaryContainer,
                     borderRadius: BorderRadius.circular(23)),
                 child: Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Image.asset('assets/images/united-kingdom@3x.png',height: 30,),
                       const Spacer(),
                       Text(
                         "English",
                         style: TextStyle(
                             fontSize: 16,
                             color: Theme.of(context)
                                 .colorScheme
                                 .onTertiary),
                       ),
                      const Spacer(),
                      Obx(() => Opacity(
                           opacity:controller.selectedLanguage.value=='en'?1:0,
                           child: Image.asset('assets/images/Group 7053@3x.png',height: 25,))),
                     ],
                   ),
                 ),
               ),
             ),

              SizedBox(
                height: 2.h,
              ),
             InkWell(
               onTap: () {
                 controller.selectedLanguage.value='ar';
               },
               child: Container(
                 decoration: BoxDecoration(
                     color: Theme.of(context).colorScheme.primaryContainer,
                     borderRadius: BorderRadius.circular(23)),
                 child: Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Image.asset('assets/images/united-arab-emirates@3x.png',height: 30,),
                       const Spacer(),
                       Text(
                         "Arabic",
                         style: TextStyle(
                             fontSize: 16,
                             color: Theme.of(context)
                                 .colorScheme
                                 .onTertiary),
                       ),
                      const Spacer(),
                      Obx(() => Opacity(
                           opacity: controller.selectedLanguage.value=='ar'?1:0,
                           child: Image.asset('assets/images/Group 7053@3x.png',height: 30,))),
                     ],
                   ),
                 ),
               ),
             ),
              SizedBox(
                height: 2.h,
              ),
              InkWell(
                onTap: () {
                  controller.selectedLanguage.value='ku';
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(23)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('assets/images/g15642@3x.png',height: 30,),
                        const Spacer(),
                        Text(
                          "Kurdish",
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onTertiary),
                        ),
                       const Spacer(),
                       Obx(() => Opacity(
                            opacity: controller.selectedLanguage.value=='ku'?1:0,
                            child: Image.asset('assets/images/Group 7053@3x.png',height: 25,))),
                      ],
                    ),
                  ),
                ),
              ),
           ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding:EdgeInsets.only(bottom: 20.sp),
        child: SizedBox(
          height: 6.h,
          child: GestureDetector(
              onTap: () async{
                Get.updateLocale(Locale(controller.selectedLanguage.value));
                controller.setLanguage(controller.selectedLanguage.value);
                if(widget.pageName=='setting'){
                  await controller.updateLanguage(controller.selectedLanguage.value);
                  Get.back();
                 }else{
                  Get.offAndToNamed(Routes.loginScreen);
                }
              },
              child: BorderedButton(
                width: 1,
                text: "CONTINUE".tr,
                isReversed: true,
              )),
        ),
      ),
    );
  }
}
