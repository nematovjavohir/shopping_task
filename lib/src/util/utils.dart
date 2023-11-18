import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class Utils {
  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height / 812;
  }

  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width / 375;
  }
  static String getNumber(int number) {
    if (number < 10) {
      return "0$number";
    } else {
      return number.toString();
    }
  }

  static String getDay(int value) {
    if (value < 10) {
      return "0" + value.toString();
    } else {
      return value.toString();
    }
  }
}
