import 'package:flutter/material.dart';

import '../utils/utils.dart';

class Txt extends StatelessWidget {
  final String? text;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final bool hasBold, hasItalic, hasUnderLine, hasLineThrough, checkOverFlow, removeHTML;
  final Color? textColor;
  final Color? decorationClr;
  final TextStyle? textStyle;
  final double? fontSize, lineHeight , decorationThickness;
  final TextOverflow? overflow;
  final int? maxLine;
  final TextAlign textAlign;
  final TextDecoration? textDecoration;
  final TextDecorationStyle?  decorationStyle;
  final TextScaler? textScaler;
  final Function()? onTap;

  const Txt(
      this.text, {
        this.hasBold = false,
        this.hasItalic = false,
        this.hasUnderLine = false,
        this.hasLineThrough = false,
        this.textColor,
        this.decorationClr,
        this.decorationStyle,
        this.textStyle,
        this.fontSize,
        this.fontWeight,
        this.decorationThickness,
        this.overflow,
        this.checkOverFlow = false,
        this.maxLine,
        this.textAlign = TextAlign.start,
        this.fontFamily,
        this.textDecoration,
        this.removeHTML = false,
        this.onTap,
        this.lineHeight,
        this.textScaler,
        super.key,
      });

  @override
  Widget build(BuildContext context) {
    // If removeHTML flag is true, clean text
    final String finalText = removeHTML ? pRemoveHtmlIfNeeded(text ?? '') : (text ?? '');

    return GestureDetector(
      onTap: onTap,
      child: Text(
        finalText,
        maxLines: maxLine,
        textAlign: textAlign,
        textScaler: textScaler,
        overflow: overflow ?? (checkOverFlow ? TextOverflow.ellipsis : TextOverflow.visible),
        style: (textStyle ?? const TextStyle()).copyWith(
          fontWeight: hasBold
              ? (fontWeight ?? Static.fontWeight ?? FontWeight.bold)
              : (fontWeight ?? Static.fontWeight ?? FontWeight.normal),
          fontStyle: hasItalic ? FontStyle.italic : FontStyle.normal,
          decoration: textDecoration ??
              (hasUnderLine
                  ? TextDecoration.underline
                  : hasLineThrough
                  ? TextDecoration.lineThrough
                  : TextDecoration.none),
          color: textColor ?? Colors.black,
          fontSize: fontSize ?? Static.txtDefaultFontSize ?? 14.0,
          fontFamily: fontFamily ?? Static.txtFontFamily ?? Static.fontFamily,
          height: lineHeight,
          decorationColor: decorationClr ?? textColor,
          decorationStyle: decorationStyle ?? (hasUnderLine || hasLineThrough ? TextDecorationStyle.solid : null),
          decorationThickness: (hasUnderLine || hasLineThrough) ? decorationThickness??1.0 : null,
        ),
      ),
    );
  }
}

// Example helper (put this in utils.dart if missing)
String pRemoveHtmlIfNeeded(String input) {
  final exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
  return input.replaceAll(exp, '');
}
