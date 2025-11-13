import 'package:flutter/material.dart';
import '../global_config/btn_config.dart';

class Btn extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;

  final Color? textColor, bgColor, shadowColor, onSurface, borderColor;
  final Color? loaderColor, decorationColor;
  final bool hasBorder, isLoose, hasBold, isTextOnly, isLoading;
  final double? decorationThickness;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextDecoration? textDecoration;
  final double? radius, textSize, verticalPadding, elevation, borderWidth, width, height;
  final Widget? preFix, postFix, loader;
  final TextStyle? textStyle;
  final ButtonStyle? style;
  final EdgeInsetsGeometry? padding;
  final Size? minimumSize, maximumSize, fixedSize;
  final BorderSide? side;
  final OutlinedBorder? shape;
  final MainAxisAlignment mainAxisAlignment;

  final BtnConfig? config;

  const Btn({
    super.key,
    required this.text,
    this.onPressed,
    this.textColor,
    this.bgColor,
    this.shadowColor,
    this.onSurface,
    this.borderColor,
    this.loaderColor,
    this.decorationColor,
    this.hasBorder = true,
    this.isLoose = false,
    this.hasBold = false,
    this.isTextOnly = false,
    this.isLoading = false,
    this.decorationThickness,
    this.fontWeight,
    this.fontFamily,
    this.textDecoration,
    this.radius,
    this.textSize,
    this.verticalPadding = 4,
    this.elevation,
    this.borderWidth = 1,
    this.width,
    this.height,
    this.preFix,
    this.postFix,
    this.loader,
    this.textStyle,
    this.style,
    this.padding,
    this.minimumSize,
    this.maximumSize,
    this.fixedSize,
    this.side,
    this.shape,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.config,
  });

  @override
  Widget build(BuildContext context) {
    final mergedGlobal = BtnConfig.global.merge(config);

    return SizedBox(
      height: height ?? mergedGlobal.height ?? 48,
      width: width,
      child: _buildButton(mergedGlobal),
    );
  }

  Widget _buildButton(BtnConfig mergedGlobal) {
    if (isLoading) {
      return _button(
        loader ??
            SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: loaderColor ?? textColor ?? Colors.white,
              ),
            ),
      );
    }

    List<Widget> children = [];
    if (preFix != null) children.add(preFix!);
    if (preFix != null) children.add(SizedBox(width: verticalPadding));
    children.add(Text(
      text!,
      style: textStyle ?? _textStyle(mergedGlobal),
    ));
    if (postFix != null) {
      children.add(SizedBox(width: verticalPadding));
      children.add(postFix!);
    }

    return _button(
      Row(
        mainAxisSize: isLoose ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: mainAxisAlignment,
        children: children,
      ),
    );
  }

  Widget _button(Widget child) {
    return ElevatedButton(
      style: style ??
          ElevatedButton.styleFrom(
            backgroundColor: isTextOnly
                ? Colors.transparent
                : (bgColor ?? BtnConfig.global.bgColor ?? Colors.blue),
            foregroundColor: textColor ?? BtnConfig.global.textColor ?? Colors.white,
            disabledForegroundColor: textColor ?? Colors.white,
            disabledBackgroundColor: isTextOnly
                ? Colors.transparent
                : (bgColor ?? BtnConfig.global.bgColor ?? Colors.blue),
            elevation: isTextOnly ? 0 : elevation ?? 2,
            shadowColor: shadowColor ?? Colors.black26,
            shape: shape ??
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    radius ?? BtnConfig.global.radius ?? 8,
                  ),
                  side: hasBorder
                      ? BorderSide(
                    color: borderColor ??
                        BtnConfig.global.borderColor ??
                        (bgColor ?? Colors.blue),
                    width: borderWidth!,
                  )
                      : BorderSide.none,
                ),
          ),
      onPressed: isLoading ? null : onPressed,
      child: Padding(
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: 16,
              vertical: verticalPadding ?? 8,
            ),
        child: child,
      ),
    );
  }

  TextStyle _textStyle(BtnConfig mergedGlobal) {
    return TextStyle(
      color: isTextOnly
          ? (textColor ?? mergedGlobal.textColor ?? Colors.black)
          : textColor ?? mergedGlobal.textColor ?? Colors.white,
      fontSize: textSize ?? mergedGlobal.textSize ?? 16,
      fontWeight: hasBold ? fontWeight ?? FontWeight.bold : fontWeight ?? FontWeight.normal,
      fontFamily: fontFamily ?? mergedGlobal.fontFamily,
      decoration: textDecoration,
      decorationColor: decorationColor ?? textColor ?? Colors.black,
      decorationThickness: decorationThickness ?? 1.5,
    );
  }
}



