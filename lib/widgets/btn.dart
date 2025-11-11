import 'package:flutter/material.dart';

import '../utils/utils.dart';

class Btn extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;

  // Loader
  final bool isLoading;
  final Widget? loadingWidget;
  final Color? loadingColor;

  // Style
  final Color? textColor;
  final Color? bgColor;
  final Color? borderColor;
  final Color? shadowColor;
  final Color? onSurface;
  final bool hasBorder;
  final bool isLoose;
  final bool hasBold;
  final bool isTextOnly;

  final TextDecoration? textDecoration;

  // Dimensions
  final double? radius;
  final double? textSize;
  final double? verticalPadding;
  final double? elevation;
  final double? borderWidth;
  final double? width;
  final double? height;

  // Prefix / Postfix
  final Widget? preFix;
  final Widget? postFix;

  // Text
  final TextStyle? textStyle;
  final String? fontFamily;
  final FontWeight? fontWeight;

  const Btn({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.loadingWidget,
    this.loadingColor,
    this.textColor,
    this.bgColor,
    this.borderColor,
    this.shadowColor,
    this.onSurface,
    this.hasBorder = true,
    this.isLoose = false,
    this.hasBold = false,
    this.isTextOnly = false,
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
    this.textStyle,
    this.fontFamily,
    this.fontWeight,
  });

  @override
  State<Btn> createState() => _BtnState();
}

class _BtnState extends State<Btn> {
  late Color? textColor;
  late Color? bgColor;
  late Color? borderColor;

  @override
  void initState() {
    super.initState();
    textColor = widget.textColor ?? Colors.white;
    bgColor = widget.bgColor ?? Colors.blue;
    borderColor = widget.borderColor ?? Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? Static.btnHeight ?? 48,
      width: widget.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.isTextOnly ? Colors.transparent : bgColor ?? Static.btnBackgroundColor,
          foregroundColor: textColor ?? Static.btnTextColor ?? Colors.black,
          elevation: widget.isTextOnly ? 0 : widget.elevation,
          shadowColor: widget.shadowColor ?? Colors.black12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.radius ?? Static.btnRadius ?? 8.0),
          ),
          side: widget.hasBorder
              ? BorderSide(
            color: widget.isTextOnly
                ? (borderColor ?? Static.btnBorderColor?? Colors.blue): borderColor?? Static.btnBorderColor ??Colors.black,
            width: widget.borderWidth ?? 1,
          )
              : BorderSide.none,
        ),
        onPressed: widget.isLoading ? (){} : widget.onPressed,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Opacity(
              opacity: widget.isLoading ? 0.0 : 1.0,
              child: Row(
                mainAxisSize: widget.isLoose ? MainAxisSize.max : MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.preFix != null) ...[
                    widget.preFix!,
                    SizedBox(width: widget.verticalPadding),
                  ],
                  Text(
                    widget.text,
                    style: widget.textStyle ??
                        TextStyle(
                          color: textColor,
                          fontSize: widget.textSize ?? 16,
                          fontWeight: widget.hasBold
                              ? FontWeight.bold
                              : widget.fontWeight ?? FontWeight.normal,
                          fontFamily: widget.fontFamily,
                          decoration: widget.textDecoration?? TextDecoration.none,
                        ),
                  ),
                  if (widget.postFix != null) ...[
                    SizedBox(width: widget.verticalPadding),
                    widget.postFix!,
                  ],
                ],
              ),
            ),
            if (widget.isLoading)
              widget.loadingWidget ?? Static.btnLoadingWidget ??
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        widget.loadingColor ?? Static.btnLoadingColor ?? Colors.black,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
