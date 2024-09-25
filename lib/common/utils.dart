
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'color_constants.dart';

// void storeValue(String key, String value) async {
//   GetStorage box = Get.find<GetStorage>();
//   await box.write(key, value);
// }
//
// String getValue(String key) {
//   GetStorage box = Get.find<GetStorage>();
//   var value = box.read(key);
//   return value.toString();
// }

Text addarialText(String text,Color color,double fontsize,FontWeight fontWeight){
  return
    Text(text,style: TextStyle(color: color,fontSize: fontsize.sp,fontWeight: fontWeight,fontFamily: 'Arial'))
  ;
}

Text addText(String text, double size, Color color, FontWeight fontWeight,{int ?maxLines}) {
  return Text(text,overflow:TextOverflow.visible,maxLines:maxLines??20,
      style: TextStyle(color: color, fontSize: size,fontWeight: fontWeight));
}

Text addSpaceText(String text, double size, Color color, FontWeight fontWeight) {
  return Text(text,
      style: TextStyle(color: color, fontSize: size, fontWeight: fontWeight,letterSpacing: 2));
}

Text addOverflowText(
    String text, double size, Color color, FontWeight fontWeight) {
  return Text(text.tr,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
        overflow: TextOverflow.ellipsis,
      ));
}

Text addAlignedText(
    String text, double size, Color color, FontWeight fontWeight) {
  return Text(text,
      textAlign: TextAlign.center,
      style: TextStyle(color: color, fontSize: size, fontWeight: fontWeight));
}

Text addUnderlineLineText(
    String text, double size, Color color, FontWeight fontWeight) {
  return Text(text,
      style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: fontWeight,
          decoration: TextDecoration.underline));
}

Widget addEditText(TextEditingController controller, String hintText, {TextInputType type = TextInputType.multiline}) {
  return Expanded(
    child: TextFormField(
      cursorColor: ColorConstants.primaryColor,
      keyboardType: type,
      controller: controller,
      textInputAction: TextInputAction.next,
      style: TextStyle(fontSize: getSubheadingTextFontSIze()),
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: getSubheadingTextFontSIze(),
              color: Theme.of(Get.context!).colorScheme.onTertiary),
          border: InputBorder.none),
    ),
  );
}

Widget addSmallEditText(TextEditingController controller, String hintText,{InputBorder border=InputBorder.none,Function(String)? callback}) {
  return TextFormField(
    cursorColor: ColorConstants.primaryColor,
    keyboardType: TextInputType.multiline,
    controller: controller,
    textInputAction: TextInputAction.next,
    onChanged: callback,
    style: TextStyle(fontSize: getNormalTextFontSIze()),
    decoration: InputDecoration(
        hintText: hintText.tr,
        hintStyle: TextStyle(
            color: Colors.black,
            fontSize: getNormalTextFontSIze(),),
        border: border),
  );
}


Widget addSmallLightEditText(TextEditingController controller, String hintText,{required Function(String) callback}) {
  return TextFormField(
    cursorColor: ColorConstants.primaryColor,
    keyboardType: TextInputType.multiline,
    controller: controller,
    onChanged:callback,
    textInputAction: TextInputAction.next,
    style: TextStyle(fontSize: getNormalTextFontSIze(),color: ColorConstants.borderColor),
    decoration: InputDecoration(
        hintText: hintText.tr,
        hintStyle: TextStyle(
            fontSize: getNormalTextFontSIze(),
            color: ColorConstants.borderColor),
        border: InputBorder.none),
  );
}

Widget addSmallEditText2(TextEditingController controller, String hintText, {TextInputType inputType = TextInputType.multiline}) {
  return TextFormField(
    cursorColor: ColorConstants.primaryColor,
    keyboardType: inputType,
    controller: controller,
    textInputAction: TextInputAction.next,
    style: TextStyle(fontSize: getSmallTextFontSIze()),
    decoration: InputDecoration(
      contentPadding: EdgeInsets.zero,
        hintText: hintText.tr,
        isDense: true,
        hintStyle: TextStyle(
            fontSize: getSmallTextFontSIze(),
            color: Theme.of(Get.context!).colorScheme.onTertiary),
        border: InputBorder.none),
  );
}

Widget addEditText2(TextEditingController controller, String hintText,{Function(String) ?callback,int ? maxLength,TextInputType inputType=TextInputType.multiline}) {
  return TextFormField(
    cursorColor: ColorConstants.primaryColor,
    keyboardType: inputType,
    controller: controller,
    inputFormatters: [],
    textInputAction: TextInputAction.next,
    maxLength:maxLength,
    onChanged: callback,
    style: TextStyle(fontSize: getNormalTextFontSIze()+1,color:Theme.of(Get.context!).colorScheme.tertiary),
    decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
            color: Theme.of(Get.context!).colorScheme.error,
            fontWeight: FontWeight.w300,
          fontSize: getNormalTextFontSIze()
        ),
        border: InputBorder.none),
  );
}

Widget addPrimaryColorEditText(
    TextEditingController controller, String hintText,
    {required Function(String) callback}) {
  return TextFormField(
    cursorColor: ColorConstants.primaryColor,
    keyboardType: TextInputType.multiline,
    controller: controller,
    textInputAction: TextInputAction.next,
    onChanged:callback,
    style: TextStyle(
        fontSize: getHeadingTextFontSIze(),
        color: ColorConstants.primaryColor,
        fontWeight: FontWeight.w500),
    decoration: InputDecoration(
        hintText: hintText.tr,
        hintStyle: TextStyle(
            fontSize: getSubheadingTextFontSIze(),
            color: Theme.of(Get.context!).colorScheme.error,),
        border: InputBorder.none),
  );
}


double getSmallestTextFontSIze() {
  return 1.2.h;
}

double getSmallTextFontSIze() {
  return 1.4.h;
}

double getNormalSmallTextFontSIze() {
  return 13.sp;
}

double getNormalTextFontSIze() {
  return 16.sp;
}

double getSubheadingTextFontSIze() {
  return 16.sp;
}

double getHeadingTextFontSIze() {
  return 17.sp;
}

double getLargeTextFontSIze() {
  return 21.sp;
}

BoxShadow getBoxShadow() {
  return const BoxShadow(
    color: Colors.black38,
    offset: Offset(
      0.0,
      1.0,
    ),
    blurRadius: 2.0,
    spreadRadius: 0.0,
  );
}

BoxShadow getLightBoxShadow() {
  return const BoxShadow(
    color: Colors.black12,
    offset: Offset(
      2.0,
      3.0,
    ),
    blurRadius: 2.0,
    spreadRadius: 0.0,
  );
}

BoxShadow getDeepBoxShadow() {
  return const BoxShadow(
    color: Colors.black12,
    offset: Offset(
      0.0,
      3.0,
    ),
    blurRadius: 10.0,
    spreadRadius: 0.0,
  );
}


// Decoration getEditTextDecoration() {
//   return BoxDecoration(
//       borderRadius: getBorderRadius(),
//       border: Border.all(color: ColorConstants.borderColor),
//       color: ColorConstants.etBgColor);
// }
//
// Decoration getPrimaryDecoration() {
//   return BoxDecoration(
//       borderRadius: getBorderRadius(),
//       border: Border.all(color: ColorConstants.primaryColor),
//       color: ColorConstants.primaryColorLight);
// }
//
// Decoration getPrimaryDecoration2() {
//   return BoxDecoration(
//       borderRadius: getBorderRadius(),
//       boxShadow: [getBoxShadow()],
//       // border: Border.all(color: ColorConstants.primaryColor),
//       color: ColorConstants.primaryColorLight);
// }
//
// Decoration getPrimaryDecoration3() {
//   return BoxDecoration(
//       borderRadius: getBorderRadius(),
//       border: Border.all(color: ColorConstants.primaryColor),
//       color: ColorConstants.primaryColorLight);
// }

BorderRadius getBorderRadius() {
  return BorderRadius.circular(10);
}

BorderRadius getEdgyBorderRadius() {
  return BorderRadius.circular(8);
}

BorderRadius getBorderRadiusCircular() {
  return BorderRadius.circular(200);
}

BorderRadius getCurvedBorderRadius() {
  return BorderRadius.circular(20);
}

BorderRadius getCustomBorderRadius(double radius) {
  return BorderRadius.circular(radius);
}


// Widget buildColorInfoItems(String title, String description, Color color) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 0),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Row(
//           children: [
//             addText(title, getSmallTextFontSIze() + 1, ColorConstants.black,
//                 FontWeight.normal),
//             addText(' : $description', getSmallTextFontSIze() + 1, color,
//                 FontWeight.bold),
//           ],
//         ),
//         SizedBox(
//           height: 1.h,
//         )
//       ],
//     ),
//   );
// }
//
// Widget buildInputField(String fieldName, TextEditingController controller) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       addText(fieldName, getNormalTextFontSIze(), ColorConstants.black,
//           FontWeight.w700),
//
//       Container(
//         width: 65.w,
//         decoration: getEditTextDecoration(),
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: TextFormField(
//           cursorColor: ColorConstants.primaryColor,
//           keyboardType: TextInputType.text,
//           controller: controller,
//           textInputAction: TextInputAction.next,
//           style: TextStyle(fontSize: getNormalTextFontSIze()),
//           decoration: InputDecoration(
//               hintText: 'Type here.....'.tr,
//               hintStyle: TextStyle(
//                   fontSize: getNormalTextFontSIze(),
//                   color: Theme.of(Get.context!).colorScheme.error),
//               border: InputBorder.none),
//         ),
//       )
//
//       // Flexible(
//       //   flex: 7,
//       //   child: addDecoratedEditText(controller, 'Type here.....'),
//       // )
//     ],
//   );
// }
// //
// void showToast(String message) {
//   Fluttertoast.showToast(
//       msg: message,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 1,
//       backgroundColor: ColorConstants.primaryColor,
//       textColor: ColorConstants.white,
//       fontSize: 16.0);
// }

// Widget getLightDivider() {
//   return Divider(
//     color: ColorConstants.borderColor2,
//     height: 3.h,
//   );
// }
//
//
// Widget buildDivider() {
//   return Divider(
//     color: ColorConstants.borderColor2.withOpacity(0.5),
//     thickness: 2,
//     height: 3.h,
//   );
// }



Future<DateTime?> showPicker(BuildContext context,{DateTime? firstDate}) async {
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: firstDate??DateTime.now(),
      firstDate:firstDate?? DateTime(2015, 8),
      lastDate: DateTime(2101));
  if (picked != null) {
    return picked;
  }
  return null;
}
