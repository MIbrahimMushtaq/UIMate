import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../utils/utils.dart';

void pShowToast({
  required String message,
  Color? colorText,
  Color? backgroundColor,
  Color? errorBackgroundColor,
  bool isError = false,
  ToastGravity? toastGravity,
  Toast? toastLength,
  Duration? duration,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: toastLength ?? Toast.LENGTH_SHORT,
    gravity: toastGravity ?? ToastGravity.BOTTOM,
    backgroundColor: isError
        ? (errorBackgroundColor ?? Colors.red)
        : (backgroundColor ?? Clr.colorPrimary),
    textColor: colorText ?? Colors.white,
    fontSize: 16.0,
    timeInSecForIosWeb: duration?.inSeconds ?? 3,
  );
}
