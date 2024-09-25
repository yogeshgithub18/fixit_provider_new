import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class MapUtils{
  MapUtils._();


  static Future<void> openMap(lat,long) async {
    double destinationLatitude = lat;
    double destinationLongitude = long;
    if (Platform.isAndroid) {
      Uri googleUrl =Uri.parse('https://www.google.com/maps/search/?api=1&query=$destinationLatitude,$destinationLongitude');
      if (await canLaunchUrl(googleUrl)) {
         await launchUrl(googleUrl);
      } else {
        throw 'Could not launch $googleUrl';
      }
    } else {
      Uri iosUrl =Uri.parse('https://maps.apple.com/?q=$destinationLatitude,$destinationLongitude');
      if (await canLaunchUrl(iosUrl)) {
        await launchUrl(iosUrl);
      } else {
        throw 'Could not open the map.';
      }
    }
  }
  // static Future<void> openMap(lat,long) async {
  //    double destinationLatitude= lat;
  //    double destinationLongitude = long;
  //   final uri = Uri(
  //       scheme:Platform.isAndroid?"google.navigation":"maps.google.com",
  //       queryParameters: {
  //         'q': '$destinationLatitude, $destinationLongitude'
  //       });
  //   if (await canLaunchUrl(uri)) {
  //     await launchUrl(uri);
  //   } else {
  //     debugPrint('An error occurred');
  //   }
  //  }
  }
