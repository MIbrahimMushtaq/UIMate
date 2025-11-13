import 'package:flutter/material.dart';

class BtnConfig {
  final double? height;
  final Color? bgColor;
  final bool? hasBorder;
  final Color? borderColor;
  final double? radius;
  final double? verticalPadding;

  final Color? textColor;
  final String? fontFamily;
  final double? textSize;
  final bool? hasBold;

  static BtnConfig global = const BtnConfig();

  const BtnConfig({
    this.height,
    this.bgColor,
    this.hasBorder,
    this.borderColor,
    this.radius,
    this.verticalPadding,
    this.textColor,
    this.fontFamily,
    this.textSize,
    this.hasBold,
  });

  /// Merge local config with global defaults
  BtnConfig merge(BtnConfig? local) {
    if (local == null) return this;
    return BtnConfig(
      height: local.height ?? height,
      bgColor: local.bgColor ?? bgColor,
      hasBorder: local.hasBorder ?? hasBorder,
      borderColor: local.borderColor ?? borderColor,
      radius: local.radius ?? radius,
      verticalPadding: local.verticalPadding ?? verticalPadding,
      textColor: local.textColor ?? textColor,
      fontFamily: local.fontFamily ?? fontFamily,
      textSize: local.textSize ?? textSize,
      hasBold: local.hasBold ?? hasBold,
    );
  }
}
