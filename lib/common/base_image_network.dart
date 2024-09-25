import 'package:flutter/material.dart';
import '../../backend/api_end_points.dart';

class BaseImageNetwork extends StatelessWidget {
  final String? link;
  final bool? concatBaseUrl;
  final double? borderRadius;
  final BoxFit? fit;
  final Widget? errorWidget;
  final double? topMargin, bottomMargin, rightMargin, leftMargin, height, width;
  const BaseImageNetwork(
      {Key? key,
      this.link,
      this.topMargin,
      this.bottomMargin,
      this.rightMargin,
      this.leftMargin,
      this.height,
      this.width,
      this.concatBaseUrl,
      this.borderRadius,
      this.fit,
      this.errorWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: topMargin ?? 0,
          right: rightMargin ?? 0,
          bottom: bottomMargin ?? 0,
          left: leftMargin ?? 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
        child: Image.network(
          (((link ?? "").contains("https")) || ((link ?? "").contains("http")))
              ? (link ?? "")
              : ApiEndPoints().imageBaseUrl + (link ?? ""),
          width: width,
          height: height,
          alignment: Alignment.topCenter,
          fit: fit ?? BoxFit.fitHeight,
          errorBuilder: (context, url, error) {
            if (errorWidget == null) {
              return Icon(Icons.image, size: width);
            } else {
              return errorWidget ?? const SizedBox();
            }
          },
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }
}
