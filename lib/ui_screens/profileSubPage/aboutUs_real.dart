import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../backend/api_end_points.dart';
import '../../backend/base_api.dart';
import '../../backend/modal/page_response.dart';
import '../../common/base_overlays.dart';
import '../app_header.dart';

class AboutUsReal extends StatefulWidget {
  const AboutUsReal({
    Key? key,
  }) : super(key: key);

  @override
  State<AboutUsReal> createState() => _AboutUsRealState();
}

class _AboutUsRealState extends State<AboutUsReal> {
  PageData data = PageData();
  bool isLoader=true;
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(5.h),
          child: AppHeader(
            showBackIcon: true,
            title: 'About Us'.tr,
          )),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: isLoader?Center(child: const CircularProgressIndicator()):data.aboutUs == null
              ? const SizedBox.shrink()
              : SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                  Html(
                      data: data.aboutUs,
                      style: {
                        "h2": Style(
                          color: Theme.of(context)
                              .colorScheme
                              .tertiary, // Customize the text color for <p> tag
                          fontSize: FontSize
                              .large, // Customize the font size for <p> tag
                        ),
                        "p": Style(
                          color: Theme.of(context)
                              .colorScheme
                              .onTertiary, // Customize the text color for <p> tag
                          fontSize: FontSize
                              .large, // Customize the font size for <p> tag
                        ),
                        "strong": Style(
                          fontWeight:
                          FontWeight.bold, // Make <strong> text bold
                        ),
                      },
                    ),
                  ],
                ),
              ))),
    );
  }

  getData() async {
    await BaseAPI()
        .get(url: ApiEndPoints().aboutUs, showLoader: false)
        .then((value) {
      isLoader=false;
      if (value?.statusCode == 200) {
        data = PageResponse.fromJson(value?.data).data ?? PageData();
        setState(() {});
      } else {
        BaseOverlays()
            .showSnackBar(message: "Something Went Wrong!!".tr, title: "Error".tr);
      }
    });
  }
}
