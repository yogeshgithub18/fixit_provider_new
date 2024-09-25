import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'color_constants.dart';

class BaseOverlays {
  showMediaPickerDialog(
      {Function()? onCameraClick, Function()? onGalleryClick}) {
    final ImagePicker picker = ImagePicker();
    showGeneralDialog(
      context: Get.context!,
      barrierDismissible: true,
      barrierLabel: "",
      pageBuilder: (context, a1, a2) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 3.w),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(14))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: SvgPicture.asset("assets/images/ic_close.svg",
                          height: 16)),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                      onTap: onCameraClick ??
                          () async {
                            Get.back();
                            await picker
                                .pickImage(source: ImageSource.camera)
                                .then((value) {
                              if (value != null) {
                              }
                            });
                          },
                      child:  Column(
                        children: [
                          const Icon(Icons.camera_alt_outlined,
                              color: ColorConstants.primaryColor, size: 60),
                          const SizedBox(height: 8),
                          Text("Camera".tr),
                        ],
                      ),
                    )),
                    Expanded(
                        child: GestureDetector(
                      onTap: onGalleryClick ??
                          () async {
                            Get.back();
                            await picker
                                .pickImage(source: ImageSource.gallery)
                                .then((value) {
                              if (value != null) {
                              }
                            });
                          },
                      child:  Column(
                        children: [
                          const Icon(Icons.photo_library_outlined,
                              color: ColorConstants.primaryColor, size: 60),
                          const SizedBox(height: 8),
                          Text("Gallery".tr),
                        ],
                      ),
                    )),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Loading
  void showLoader({bool? showLoader}) {
    if (showLoader ?? true) {
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (context) => WillPopScope(
          onWillPop: () async => false,
          child: Container(
            color: Colors.black26,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: const Center(
              child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
        ),
      );
    }
  }

  /// Dismiss Loader
  void dismissOverlay({bool? showLoader}) {
    if (showLoader ?? true) {
      Get.back(closeOverlays: true);
    }
  }

  void showSnackBar({String? title, required String message}) {
    Get.closeCurrentSnackbar();
    Get.closeAllSnackbars();
    Get.snackbar(
      title?.tr ?? "Error".tr,
      message,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      backgroundColor: (title?.tr) == "Success".tr
          ? (Colors.green.shade800)
          : Colors.red,
      margin: EdgeInsets.zero,
      borderRadius: 0,
      icon: Icon(
              (title?.tr) == "Success".tr
              ? Icons.check_circle_outline
              : Icons.error_outline,
          color: Colors.white),
    );
  }

  void warningShowSnackBar({String? title, required String message}) {
    Get.closeCurrentSnackbar();
    // Get.closeAllSnackbars();
    Get.snackbar(
      title ?? "Warning".tr,
      message,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      backgroundColor: ColorConstants.primaryColor,
      margin: EdgeInsets.zero,
      borderRadius: 0,
      icon: const Icon(Icons.error_outline, color: Colors.white),
    );
  }
}
