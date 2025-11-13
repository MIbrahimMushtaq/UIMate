import 'package:flutter/material.dart';
import 'package:ui_mate/widgets/txt_input.dart';
class TxtFormInputConfig {
  static TxtFormInputConfig global = TxtFormInputConfig();

  final String? fontFamily;
  final String? labelFontFamily;
  final String? hintFontFamily;

  final double? labelTextSize;
  final double? hintTextSize;
  final Color? labelTextColor;
  final Color? hintTextColor;
  final FontStyle? labelFontStyle;
  final FontStyle? hintFontStyle;
  final FontWeight? labelFontWeight;
  final FontWeight? hintFontWeight;

  final double? borderWidth;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final Color? fillColor;
  final Color? cursorColor;
  final double? labelPadding;
  final double? height;
  final TxtInputBorderType? borderType;

  const TxtFormInputConfig({
    this.fontFamily,
    this.labelFontFamily,
    this.hintFontFamily,
    this.labelTextSize,
    this.hintTextSize,
    this.labelTextColor,
    this.hintTextColor,
    this.labelFontStyle,
    this.hintFontStyle,
    this.labelFontWeight,
    this.hintFontWeight,
    this.borderWidth,
    this.borderRadius,
    this.borderColor,
    this.fillColor,
    this.cursorColor,
    this.labelPadding,
    this.height,
    this.borderType,
  });
}