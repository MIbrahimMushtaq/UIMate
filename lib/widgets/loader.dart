import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/utils.dart';

class LoadingPro extends StatelessWidget {
  final double? size;
  final bool isLinear;
  final Color? valueColor;
  final Color? backgroundColor;
  final bool? platFormIsIOS;
  final Widget? customLoadingWidget;
  final double strokeWidth;

  const LoadingPro({
    this.size,
    this.isLinear = false,
    this.valueColor,
    this.backgroundColor,
    this.platFormIsIOS,
    this.customLoadingWidget,
    this.strokeWidth = 3.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Use custom widget if provided
    if (customLoadingWidget != null) {
      return customLoadingWidget!;
    }

    // Fallback to global custom widget if set in Static
    if (Static.customLoadingProWidget != null) {
      return Static.customLoadingProWidget!;
    }

    final loaderColor = valueColor ?? Clr.colorPrimary;
    final bgColor = backgroundColor ?? Colors.transparent;
    final isIOS = platFormIsIOS ?? Static.defaultLoadingProIsIOS ?? Platform.isIOS;

    if (isLinear) {
      return SizedBox(
        width: size ?? double.infinity,
        height: (size ?? 4),
        child: LinearProgressIndicator(
          backgroundColor: bgColor,
          valueColor: AlwaysStoppedAnimation<Color>(loaderColor),
        ),
      );
    }

    return SizedBox(
      width: size ?? 30,
      height: size ?? 30,
      child: Center(
        child: isIOS
            ? CupertinoActivityIndicator(
          color: loaderColor,
          radius: (size ?? 30) / 2.5, // scaled with size
        )
            : CircularProgressIndicator(
          strokeWidth: strokeWidth,
          backgroundColor: bgColor,
          valueColor: AlwaysStoppedAnimation<Color>(loaderColor),
        ),
      ),
    );
  }
}
