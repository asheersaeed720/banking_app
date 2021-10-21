import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color nearBlack = Color(0xFF213333);
  static const Color loginGradientStart = Color(0xFFfbab66);
  static const Color loginGradientEnd = Color(0xFFf7418c);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color buttonColor = Color(0xFF313445);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: <Color>[loginGradientStart, loginGradientEnd],
    stops: <double>[0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const String fontName = 'Poppins';

  static const TextTheme textTheme = TextTheme(
    headline1: headTxt1,
    headline2: headTxt2,
    bodyText1: bodyTxt1,
    subtitle1: subtitleTxt1,
  );

  static const TextStyle headTxt1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24.0,
    color: nearBlack,
  );
  static const TextStyle headTxt2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
    color: nearBlack,
  );

  static const TextStyle bodyTxt1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w600,
    fontSize: 16.0,
    color: nearBlack,
  );
  static const TextStyle subtitleTxt1 = TextStyle(
    fontFamily: fontName,
    fontSize: 13.5,
    color: Colors.black87,
  );
}
