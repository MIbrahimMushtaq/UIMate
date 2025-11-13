library;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ui_mate/utils/date.dart';
import 'package:ui_mate/utils/utils.dart';
import 'package:ui_mate/widgets/get_image.dart';
export 'helpers/box_decoration.dart';
export 'helpers/toast.dart';
export 'helpers/focus.dart';
export 'helpers/card.dart';
export 'helpers/navigation.dart';
export 'helpers/formatter.dart';

class UiMate {}
Future<void> uiSetSetting({
  required Color primaryColor,
  required Color secondaryColor,
  String defaultImage = 'assets/default.png',
  bool defImageIsAsset = true,
  double defaultRadius = 8.0,
  double defaultFontSize = 14.0,
  Color? txtColor,
  TextStyle? txtStyle,
  TextStyle? labelInputStyle,
  TextStyle? hintInputStyle,
  TextStyle? styleInput,
  String? fontFamily,
  String? txtFontFamily,
  FontWeight? fontWeight,
  bool? appDirectionLeftToRight,
  Duration? dialogAnimationDuration,
  bool defaultImageClick = true,
  InputDecoration? inputDecoration,
  Widget? customLoadingWidget,
  String? defaultDateFormat,
  String? defaultDateTimeFormat,
  Toast? defaultToastLength,
  Color? toastBackgroundColor,
  Color? toastTextColor,
  ToastGravity toastGravity = ToastGravity.BOTTOM,
  bool? defaultLoadingProIsIOS

}) async {
  await Dates.initializeDateFormat();

  Clr.colorPrimary = primaryColor;
  Clr.colorSecondary = secondaryColor;
  Clr.colorTxt = txtColor;

  GetImage.defaultImage = defaultImage;
  GetImage.defImageIsAsset = defImageIsAsset;
  Static.defaultImageClick = defaultImageClick;

  Siz.defaultRadius = defaultRadius;
  Static.fontWeight = fontWeight;
  Static.fontFamily = fontFamily;
  Static.txtFontFamily = txtFontFamily;
  Static.appDirectionLeftToRight = appDirectionLeftToRight;
  Static.customLoadingProWidget = customLoadingWidget;
  Static.toastLength = defaultToastLength;
  Static.toastBackgroundColor = toastBackgroundColor;
  Static.toastTextColor = toastTextColor;
  Static.toastGravity = toastGravity;
  Static.defaultDateFormat = defaultDateFormat;
  Static.defaultDateTimeFormat = defaultDateTimeFormat;
  Static.defaultLoadingProIsIOS = defaultLoadingProIsIOS;

}
