import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/color_constants.dart';
import '../common/utils.dart';

class AppHeader extends StatefulWidget {
  final bool showBackIcon;
  final bool? isBackIcon;
  final String title;

  const AppHeader(
      {Key? key,
      required this.showBackIcon,
      required this.title,
      this.isBackIcon = false})
      : super(key: key);

  @override
  State<AppHeader> createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: addText(widget.title, getHeadingTextFontSIze() + 3,
          Theme.of(context).colorScheme.onTertiary, FontWeight.normal),
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: ColorConstants.primaryColor),
      leading: widget.showBackIcon
          ? Center(
              child: IconButton(
              icon: Icon(
                widget.isBackIcon! ? Icons.close_sharp : Icons.arrow_back_ios,
                color: ColorConstants.primaryColor,
                size: getLargeTextFontSIze() * 1,
              ),
              onPressed: () => Get.back(),
            ))
          : const SizedBox.shrink(),
    );
  }
}
