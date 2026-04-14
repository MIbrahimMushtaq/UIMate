import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ui_mate/utils/utils.dart';

class ToastOptions {
  final ToastGravity toastGravity;
  final Toast toastLength;
  final Color backgroundColor;
  final Color textColor;
  final Color errorBackgroundColor;
  final double fontSize;

  const ToastOptions({
    required this.toastGravity,
    required this.toastLength,
    required this.backgroundColor,
    required this.textColor,
    required this.errorBackgroundColor,
    this.fontSize = 16.0,
  });
}

class ToastConfig {
  ToastOptions options = const ToastOptions(
    toastGravity: ToastGravity.TOP,
    toastLength: Toast.LENGTH_SHORT,
    backgroundColor: Clr.colorBlack,
    textColor: Colors.white,
    errorBackgroundColor: Color(0xFFE53935),
    fontSize: 16,
  );

  ToastConfig._internal();

  static final ToastConfig instance = ToastConfig._internal();

  factory ToastConfig({
    ToastGravity? toastGravity,
    Toast? toastLength,
    Color? backgroundColor,
    Color? textColor,
    Color? errorBackgroundColor,
    double? fontSize,
  }) {
    instance.options = ToastOptions(
      toastGravity: toastGravity ?? instance.options.toastGravity,
      toastLength: toastLength ?? instance.options.toastLength,
      backgroundColor: backgroundColor ?? instance.options.backgroundColor,
      textColor: textColor ?? instance.options.textColor,
      errorBackgroundColor:
      errorBackgroundColor ?? instance.options.errorBackgroundColor,
      fontSize: fontSize ?? instance.options.fontSize,
    );
    return instance;
  }
}

void pShowToast({
  required String message,
  bool isError = false,
  ToastGravity? toastGravity,
  Toast? toastLength,
  Color? backgroundColor,
  Color? errorBackgroundColor,
  Color? colorText,
  double? fontSize,
}) {
  final cfg = ToastConfig.instance.options;

  Fluttertoast.showToast(
    msg: message,
    toastLength: toastLength ?? cfg.toastLength,
    gravity: toastGravity ?? cfg.toastGravity,
    backgroundColor: isError
        ? (errorBackgroundColor ?? cfg.errorBackgroundColor)
        : (backgroundColor ?? cfg.backgroundColor),
    textColor: colorText ?? cfg.textColor,
    fontSize: fontSize ?? cfg.fontSize,
  );
}
