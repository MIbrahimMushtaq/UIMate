import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../utils/utils.dart';

void pShowToast(
    {required String message,
      Color? colorText,
      Color? backgroundColor,
      Color? errorBackgroundColor,
      bool isError = false,
      ToastGravity? toastGravity,
      Toast? toastLength}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: toastLength ?? Static.toastLength??Toast.LENGTH_SHORT,
    gravity: toastGravity ?? Static.toastGravity??ToastGravity.CENTER,
    backgroundColor: isError
        ? ((errorBackgroundColor ?? Colors.red))
        : (backgroundColor ?? Static.toastBackgroundColor?? Clr.colorPrimary),
    textColor: colorText??Static.toastTextColor??Colors.white,
    fontSize: 16.0,
  );
}
