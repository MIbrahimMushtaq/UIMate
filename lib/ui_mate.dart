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

Future<void> uiSetSetting({
  required Color primaryColor,
  required Color secondaryColor,
  String defaultImage = 'assets/default.png',
  bool defImageIsAsset = true,
  double defaultRadius = 8.0,
  double defaultFontSize = 14.0,
  Color? txtColor,
  Color? txtInputColor,
  TextStyle? txtStyle,
  TextStyle? labelInputStyle,
  TextStyle? hintInputStyle,
  TextStyle? styleInput,
  String? fontFamily,
  String? txtFontFamily,
  String? txtInputFontFamily,
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
  Color? btnBackgroundColor,
  Color? btnLoadingColor,
  double? btnHeight,
  Color?  btnTextColor,
  double? btnRadius,
  Color? btnBorderColor,
  Widget? btnLoadingWidget,
}) async {
  await Dates.initializeDateFormat();

  Clr.colorPrimary = primaryColor;
  Clr.colorSecondary = secondaryColor;
  Clr.colorTxt = txtColor;
  Clr.colorTxtInput = txtInputColor;

  GetImage.defaultImage = defaultImage;
  GetImage.defImageIsAsset = defImageIsAsset;
  Static.defaultImageClick = defaultImageClick;

  Siz.defaultRadius = defaultRadius;
  Static.fontWeight = fontWeight;
  Static.txtInputDecoration = inputDecoration;
  Static.fontFamily = fontFamily;
  Static.txtFontFamily = txtFontFamily;
  Static.txtInputFontFamily = txtInputFontFamily;
  Static.defaultFontSize = defaultFontSize;

  Static.appDirectionLeftToRight = appDirectionLeftToRight;
  Static.dialogAnimationDuration = dialogAnimationDuration;

  Static.customLoadingProWidget = customLoadingWidget;
  Static.toastLength = defaultToastLength;
  Static.toastBackgroundColor = toastBackgroundColor;
  Static.toastTextColor = toastTextColor;
  Static.toastGravity = toastGravity;

  Static.defaultDateFormat = defaultDateFormat;
  Static.defaultDateTimeFormat = defaultDateTimeFormat;
  Static.btnBackgroundColor = btnBackgroundColor;
  Static.btnLoadingColor = btnLoadingColor;
  Static.btnHeight = btnHeight;
  Static.btnTextColor = btnTextColor;
  Static.btnRadius = btnRadius;
  Static.btnBorderColor = btnBorderColor;
  Static.btnLoadingWidget = btnLoadingWidget;

}
