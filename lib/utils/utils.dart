import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/txt_input.dart';

class Clr {
  static Color colorPrimary = Colors.black;
  static Color colorSecondary = Colors.black;
  static const Color colorCyan = Colors.cyan;
  static const Color colorTransparent = Color(0x00000000);
  static const Color colorGreyLight = Color(0xFFF1F5F9);
  static const Color colorWhite = Colors.white;
  static const Color colorGreen = Colors.green;
  static const Color colorBlack = Colors.black;
  static Color? colorTxt ;
  static Color? colorTxtInput;

  Clr._();
}

class Str {
  static const String na = "N/A";

  Str._();
}
class Siz {
  Siz._();
  static double defaultRadius = 8.0;
  static const double profileImageSize = 150;
}


class Static {
  static bool defaultImageClick = true;
  static FontWeight? fontWeight;
  static double? txtDefaultFontSize;
  static Toast? toastLength;
  static ToastGravity? toastGravity;
  static String? fontFamily;
  static String? txtFontFamily;
  static String? txtInputFontFamily;
  static InputDecoration? txtInputDecoration;
  static bool? appDirectionLeftToRight;
  static Duration? dialogAnimationDuration;
  static bool? defaultLoadingProIsIOS;
  static String? defaultDateFormat;
  static String? defaultDateTimeFormat;
  static Widget? customLoadingProWidget;
  static Color? toastBackgroundColor;
  static Color? toastTextColor;
  static double? defaultFontSize = 14.0;
  static Color? btnBackgroundColor;
  static Color? btnLoadingColor;
  static double? btnHeight;
  static Color?  btnTextColor;
  static double? btnRadius;
  static Color? btnBorderColor;
  static Widget? btnLoadingWidget;

  static Color? txtInputBorderColor;

  static TextStyle? txtInputHintStyle;

  static double? txtInputHintFontSize;

  static Color? txtInputHIntColor;

  static Color? txtInputFilledColor;

  static TextStyle? txtInputStyle;

  static double? txtInputFontSize;

  static Color? txtInputColor;

  static Color? txtInputCursorColor;

  static TxtInputBorderType? txtInputBorderType;


  Static._();
}