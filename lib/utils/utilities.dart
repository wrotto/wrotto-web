import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wrotto_web/constants/strings.dart';

class Utilities {
  static DateTime minimalDate(DateTime _date) =>
      DateTime(_date.year, _date.month, _date.day);

  static String beautifulDate(DateTime date) {
    return weekdays[date.weekday - 1] +
        " , " +
        months[date.month - 1] +
        " " +
        date.day.toString() +
        " , " +
        date.year.toString() +
        " at " +
        date.hour.toString() +
        ":" +
        date.minute.toString();
  }

  static Future<void> launchInWebViewOrVC(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
