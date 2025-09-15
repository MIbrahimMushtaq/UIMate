import 'package:flutter/material.dart';
import '../utils/utils.dart';

Widget pSetCard({
  Widget? child,
  Color? shadowColor,
  double elevation = 10,
  GestureTapCallback? onTap,
  EdgeInsetsGeometry? padding,
  double paddingSize = 0,
  double? radius,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: padding ??
          EdgeInsets.only(
            left: paddingSize,
            right: paddingSize,
            top: paddingSize,
          ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? Siz.defaultRadius),
        ),
        elevation: elevation,
        shadowColor: shadowColor ?? Clr.colorPrimary,
        clipBehavior: Clip.antiAlias,
        child: child,
      ),
    ),
  );
}
