import 'package:flutter/material.dart';
import '../utils/utils.dart';

BoxDecoration pBoxDecoration({
  Color? color,
  BorderRadius? borderRadius,
  double? radius,
  double borderWidth = 1,
  String? image,
  bool isAsset = true,
  BoxFit? fit,
  DecorationImage? decorationImage,
  BoxBorder? border,
  bool hasBorder = false,
  Color? borderColor,
  List<BoxShadow>? boxShadow,
  Color shadowColor = Clr.colorWhite,
  double shadowRadius = 0,
  Offset shadowOffset = const Offset(0.0, 0.0),
  Gradient? gradient,
  BorderStyle borderStyle = BorderStyle.solid,
  BoxShape? shape,
}) {
  return BoxDecoration(
    borderRadius: shape == null
        ? borderRadius ??
        BorderRadius.all(Radius.circular(radius ?? Siz.defaultRadius))
        : null,
    border: border ??
        (hasBorder
            ? Border.all(
          color: borderColor ?? Clr.colorTransparent,
          width: borderWidth,
          style: borderStyle,
        )
            : null),
    color: color,
    shape: shape ?? BoxShape.rectangle,
    image: decorationImage ??
        (image != null
            ? isAsset
            ? DecorationImage(image: AssetImage(image), fit: fit)
            : DecorationImage(image: NetworkImage(image), fit: fit)
            : null),
    boxShadow: boxShadow ??
        [
          BoxShadow(
            color: shadowColor,
            blurRadius: shadowRadius,
            offset: shadowOffset,
          ),
        ],
    gradient: gradient,
  );
}
