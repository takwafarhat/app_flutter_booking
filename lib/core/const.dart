import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const red = Color(0xFFDB3022);
  static const black = Color(0xFF222222);
  static const lightGray = Color(0xFF9B9B9B);
  static const darkGray = Color(0xFF979797);
  static const white = Color(0xFFFFFFFF);
  static const orange = Color(0xFFFFBA49);
  static const background = Color(0xFFE5E5E5);
  static const backgroundLight = Color(0xFFF9F9F9);
  static const transparent = Color(0x00000000);
  static const success = Color(0xFF2AA952);
  static const green = Color(0xFF2AA952);
  static Color stylecolor = Colors.black38;
}

const kGrabWhiteBoldMedium = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
  fontFamily: 'Sanomat Grab Web',
  color: Colors.white,
);

const kGrabWhiteRegularSmall = TextStyle(
  fontSize: 20,
  fontFamily: 'Sanomat Grab Web',
  color: Colors.white,
);

const kGrabBlackBoldSmall = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.bold,
  fontFamily: 'Sanomat Grab Web',
  color: Colors.black,
);

const kGrabBlackBoldMedium = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  fontFamily: 'Sanomat Grab Web',
  color: Colors.black,
);

const kGrabBlackBoldLarge = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
  fontFamily: 'Sanomat Grab Web',
  color: Colors.black,
);

const kGrabBlackRegularMedium = TextStyle(
  fontSize: 20,
  fontFamily: 'Sanomat Grab Web',
  color: Colors.black,
);

const kGrabBlackRegularSmall = TextStyle(
  fontSize: 12,
  fontFamily: 'Sanomat Grab Web',
  color: Colors.black,
);

fivePercentWidth(BuildContext context) {
  return MediaQuery.of(context).size.width * 0.05;
}

percentHeight(BuildContext context, double percent) {
  return MediaQuery.of(context).size.height * percent;
}
