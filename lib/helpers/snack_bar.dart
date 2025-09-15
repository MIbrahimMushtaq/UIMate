import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/utils.dart';

void pSnackBar({
  String title = 'Info',
  required String? message,
  Color colorText = Clr.colorWhite,
  Color? backgroundColor,
  Color? borderColor,
  bool isError = false,
  SnackPosition snackPosition = SnackPosition.TOP,
  Function(GetSnackBar snackBar)? onTap,
  Duration? duration,
}) {
  Get.snackbar(
    isError ? 'Error' : title,
    message ?? '',
    colorText: isError ? Colors.white : colorText,
    backgroundColor: isError ? Colors.red : backgroundColor ?? Clr.colorPrimary,
    borderColor: borderColor,
    snackPosition: snackPosition,
    borderWidth: 2.0,
    onTap: onTap,
    duration: duration ?? const Duration(seconds: 3),
  );
}
