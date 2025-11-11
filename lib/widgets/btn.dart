// import 'package:flutter/material.dart';
//
// import '../utils/utils.dart';
//
// class Btn extends StatefulWidget {
//   final String text;
//   final VoidCallback? onPressed;
//
//   // Loader
//   final bool isLoading;
//   final Widget? loadingWidget;
//   final Color? loadingColor;
//
//   // Style
//   final Color? textColor;
//   final Color? bgColor;
//   final Color? borderColor;
//   final Color? shadowColor;
//   final Color? onSurface;
//   final bool hasBorder;
//   final bool isLoose;
//   final bool hasBold;
//   final bool isTextOnly;
//   final TextDecoration? textDecoration;
//   final Color? textDecorationColor;
//   // Dimensions
//   final double? radius;
//   final double? textSize;
//   final double? verticalPadding;
//   final double? elevation;
//   final double? borderWidth;
//   final double? width;
//   final double? height;
//
//   // Prefix / Postfix
//   final Widget? preFix;
//   final Widget? postFix;
//
//   // Text
//   final TextStyle? textStyle;
//   final String? fontFamily;
//   final FontWeight? fontWeight;
//
//   const Btn({
//     super.key,
//     required this.text,
//     this.onPressed,
//     this.isLoading = false,
//     this.loadingWidget,
//     this.loadingColor,
//     this.textColor,
//     this.bgColor,
//     this.borderColor,
//     this.shadowColor,
//     this.onSurface,
//     this.hasBorder = true,
//     this.isLoose = false,
//     this.hasBold = false,
//     this.isTextOnly = false,
//     this.textDecoration,
//     this.textDecorationColor,
//     this.radius,
//     this.textSize,
//     this.verticalPadding = 4,
//     this.elevation,
//     this.borderWidth = 1,
//     this.width,
//     this.height,
//     this.preFix,
//     this.postFix,
//     this.textStyle,
//     this.fontFamily,
//     this.fontWeight,
//   });
//
//   @override
//   State<Btn> createState() => _BtnState();
// }
//
// class _BtnState extends State<Btn> {
//   late Color? textColor;
//   late Color? bgColor;
//   late Color? borderColor;
//
//   @override
//   void initState() {
//     super.initState();
//     textColor = widget.textColor ?? Colors.white;
//     bgColor = widget.bgColor ?? Colors.blue;
//     borderColor = widget.borderColor ?? Colors.blue;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: widget.height ?? Static.btnHeight ?? 48,
//       width: widget.width,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: widget.isTextOnly ? Colors.transparent : bgColor ?? Static.btnBackgroundColor,
//           foregroundColor: textColor ?? Static.btnTextColor ?? Colors.black,
//           elevation: widget.isTextOnly ? 0 : widget.elevation,
//           shadowColor: widget.shadowColor ?? Colors.black12,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(widget.radius ?? Static.btnRadius ?? 8.0),
//           ),
//           side: widget.hasBorder
//               ? BorderSide(
//             color: widget.isTextOnly
//                 ? (borderColor ?? Static.btnBorderColor?? Colors.blue): borderColor?? Static.btnBorderColor ??Colors.black,
//             width: widget.borderWidth ?? 1,
//           )
//               : BorderSide.none,
//         ),
//         onPressed: widget.isLoading ? (){} : widget.onPressed,
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             Opacity(
//               opacity: widget.isLoading ? 0.0 : 1.0,
//               child: Row(
//                 mainAxisSize: widget.isLoose ? MainAxisSize.max : MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   if (widget.preFix != null) ...[
//                     widget.preFix!,
//                     SizedBox(width: widget.verticalPadding),
//                   ],
//                   Text(
//                     widget.text,
//                     style: widget.textStyle ??
//                         TextStyle(
//                           color: textColor,
//                           fontSize: widget.textSize ?? 16,
//                           fontWeight: widget.hasBold
//                               ? FontWeight.bold
//                               : widget.fontWeight ?? FontWeight.normal,
//                           fontFamily: widget.fontFamily,
//                           decoration: widget.textDecoration?? TextDecoration.none,
//                           decorationColor: widget.textDecorationColor?? textColor,
//                         ),
//                   ),
//                   if (widget.postFix != null) ...[
//                     SizedBox(width: widget.verticalPadding),
//                     widget.postFix!,
//                   ],
//                 ],
//               ),
//             ),
//             if (widget.isLoading)
//               widget.loadingWidget ?? Static.btnLoadingWidget ??
//                   SizedBox(
//                     width: 20,
//                     height: 20,
//                     child: CircularProgressIndicator(
//                       strokeWidth: 2,
//                       valueColor: AlwaysStoppedAnimation<Color>(
//                         widget.loadingColor ?? Static.btnLoadingColor ?? Colors.black,
//                       ),
//                     ),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../utils/utils.dart';

class Btn extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;

  // Colors
  final Color? textColor, bgColor, shadowColor, onSurface, borderColor;
  final Color? loaderColor;
  final Color? decorationColor;

  // Booleans
  final bool hasBorder, isLoose, hasBold, isTextOnly, isLoading;

  // Styling
  final double? decorationThickness;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextDecoration? textDecoration;
  final double? radius,
      textSize,
      verticalPadding,
      elevation,
      borderWidth,
      width,
      height;

  // Widgets
  final Widget? preFix;
  final Widget? postFix;
  final Widget? loader;

  final TextStyle? textStyle;
  final ButtonStyle? style;
  final EdgeInsetsGeometry? padding;
  final Size? minimumSize, maximumSize, fixedSize;
  final BorderSide? side;
  final OutlinedBorder? shape;
  final MainAxisAlignment mainAxisAlignment;

  const Btn({
    super.key,
    required this.text,
    this.onPressed,
    this.textColor,
    this.bgColor,
    this.borderColor,
    this.decorationThickness,
    this.hasBorder = true,
    this.isLoose = false,
    this.hasBold = false,
    this.isTextOnly = false,
    this.radius,
    this.textSize,
    this.preFix,
    this.postFix,
    this.textStyle,
    this.verticalPadding = 4,
    this.borderWidth = 1,
    this.style,
    this.shadowColor,
    this.onSurface,
    this.elevation,
    this.padding,
    this.minimumSize,
    this.maximumSize,
    this.fixedSize,
    this.side,
    this.shape,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.width,
    this.height,
    this.fontWeight,
    this.fontFamily,
    this.isLoading = false,
    this.loader,
    this.loaderColor,
    this.textDecoration,
    this.decorationColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? Static.btnHeight ?? 48,
      width: width,
      child: buildButton(),
    );
  }

  Widget buildButton() {
    if (isLoading) {
      return button(
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

    if (preFix != null && postFix == null) {
      return button(
        Row(
          mainAxisSize: isLoose ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: mainAxisAlignment,
          children: [
            preFix!,
            SizedBox(width: verticalPadding),
            Text(text!, style: textStyle ?? textStyleLocal()),
          ],
        ),
      );
    } else if (preFix != null && postFix != null) {
      return button(
        Row(
          mainAxisSize: isLoose ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: mainAxisAlignment,
          children: [
            preFix!,
            SizedBox(width: verticalPadding),
            Text(text!, style: textStyle ?? textStyleLocal()),
            SizedBox(width: verticalPadding),
            postFix!,
          ],
        ),
      );
    } else if (postFix != null && preFix == null) {
      return button(
        Row(
          mainAxisSize: isLoose ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: mainAxisAlignment,
          children: [
            Text(text!, style: textStyle ?? textStyleLocal()),
            SizedBox(width: verticalPadding),
            postFix!,
          ],
        ),
      );
    } else {
      return button(
        Row(
          mainAxisSize: isLoose ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: mainAxisAlignment,
          children: [
            Text(text!, style: textStyle ?? textStyleLocal()),
          ],
        ),
      );
    }
  }

  Widget button(Widget child) {
    return ElevatedButton(
      style: style ??
          ElevatedButton.styleFrom(
            backgroundColor: isTextOnly
                ? Colors.transparent
                : (bgColor ?? Colors.blue),
            foregroundColor: textColor ?? Colors.white,
            disabledForegroundColor:
            textColor ?? Colors.white, // ✅ same color even when disabled
            disabledBackgroundColor:
            isTextOnly ? Colors.transparent : (bgColor ?? Colors.blue),
            elevation: isTextOnly ? 0 : elevation ?? 2,
            shadowColor: shadowColor ?? Colors.black26,
            shape: shape ??
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius ?? 8),
                ),
            side: side ??
                (hasBorder
                    ? BorderSide(
                  color: isTextOnly
                      ? Colors.transparent
                      : borderColor ?? Colors.blue,
                  width: borderWidth!,
                )
                    : BorderSide.none),
          ),
      onPressed: isLoading ? null : onPressed,
      child: Padding(
        padding:
        padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: child,
      ),
    );
  }

  TextStyle textStyleLocal() {
    return TextStyle(
      color: isTextOnly ? (textColor ?? Static.btnTextColor ?? Colors.black) : textColor??Static.btnTextColor,
      fontSize: textSize ?? Static.btnTextSize ?? 16,
      fontWeight: hasBold
          ? fontWeight ?? FontWeight.bold
          : fontWeight ?? FontWeight.normal,
      fontFamily: fontFamily ?? Static.btnFontFamily,
      decoration: textDecoration, // ✅ supports underline/lineThrough
      decorationColor:
      decorationColor ?? textColor ?? Colors.black, // ✅ underline color
      decorationThickness: decorationThickness ?? 1.5,
    );
  }
}


