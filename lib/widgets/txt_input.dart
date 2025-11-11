import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/utils.dart';
import 'divider.dart';

// class TxtFormInput extends StatelessWidget {
//   final TextEditingController? controller;
//   final String? errorMessage, hintText, labelText, prefixText;
//   final String? errorLengthMessage;
//   final String? fontFamily;
//   final int? maxLines, minLines, maxLength, validationLength;
//   final double? textSize, hintTextSize, radius, prefixTextSize, postFixTextSize;
//   final double borderWidth;
//   final BorderRadius? borderRadius;
//   final Color? textColor, hintTextColor, prefixTextColor, postFixTextColor;
//   final List<TextInputFormatter>? inputFormatters;
//   final TextAlign textAlign;
//   final TextCapitalization textCapitalization;
//   final ValueChanged<String>? onChanged;
//   final GestureTapCallback? onTap;
//   final bool isPassword;
//   final bool enabled;
//   final bool isOptional;
//   final bool autofocus;
//   final bool hasCounter;
//   final bool? showCursor;
//   final TxtInputBorderType? borderType;
//   final TextInputType? keyboardType;
//   final TextInputAction? textInputAction;
//   final VoidCallback? onEditingComplete;
//   final FocusNode? focusNode;
//   final Widget? postFix, preFix;
//   final InputDecoration? decoration;
//   final FormFieldValidator<String>? validator;
//   final GlobalKey<FormState>? formKey;
//   final EdgeInsetsGeometry? contentPadding;
//   final Color? fillColor, borderColor, cursorColor;
//   final TextStyle? labelStyle, hintStyle, style, prefixStyle, postFixStyle;
//   final BorderSide? borderSide;
//   final bool? appDirectionLeftToRight;
//   final bool? readOnly;
//   final String? Function()? validationConditionAddOn;
//   final double? height;
//
//   const TxtFormInput({
//     super.key,
//     this.controller,
//     this.errorMessage,
//     this.errorLengthMessage,
//     this.maxLines = 1,
//     this.minLines,
//     this.maxLength,
//     this.inputFormatters,
//     this.textAlign = TextAlign.start,
//     this.textCapitalization = TextCapitalization.sentences,
//     this.textSize,
//     this.hintTextSize,
//     this.textColor,
//     this.onChanged,
//     this.onTap,
//     this.isPassword = false,
//     this.keyboardType = TextInputType.text,
//     this.textInputAction,
//     this.onEditingComplete,
//     this.focusNode,
//     this.hintText = '',
//     this.hintTextColor,
//     this.enabled = true,
//     this.postFix,
//     this.preFix,
//     this.postFixStyle,
//     this.decoration,
//     this.validator,
//     this.formKey,
//     this.isOptional = false,
//     this.validationLength,
//     this.labelText,
//     this.radius,
//     this.borderRadius,
//     this.contentPadding,
//     this.fillColor,
//     this.borderColor,
//     this.borderWidth = 1.2,
//     this.autofocus = false,
//     this.prefixText,
//     this.prefixTextSize,
//     this.postFixTextSize,
//     this.prefixTextColor,
//     this.postFixTextColor,
//     this.labelStyle,
//     this.hintStyle,
//     this.style,
//     this.prefixStyle,
//     this.hasCounter = false,
//     this.borderSide,
//     this.appDirectionLeftToRight,
//     this.showCursor,
//     this.readOnly,
//     this.validationConditionAddOn,
//     this.cursorColor,
//     this.fontFamily,
//     this.height,
//     this.borderType
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final InputDecoration effectiveDecoration = (decoration ??
//         Static.txtInputDecoration ??
//         InputDecoration(
//           border: _buildBorder(),
//           enabledBorder: _buildBorder(),
//           focusedBorder: _buildBorder(color: borderColor ?? Static.txtInputBorderColor ?? Colors.blue),
//           errorBorder: _buildBorder(color: Colors.red),
//           focusedErrorBorder: _buildBorder(color: Colors.red),
//           hintText: hintText,
//           hintStyle: hintStyle ?? Static.txtInputHintStyle ??
//               TextStyle(
//                 fontSize: hintTextSize ?? Static.txtInputHintFontSize ?? textSize,
//                 color: hintTextColor ?? Static.txtInputHIntColor ?? Colors.grey,
//                 fontFamily: fontFamily ?? Static.txtInputFontFamily,
//               ),
//           prefixIcon: preFix,
//           suffixIcon: postFix,
//           prefixText: prefixText,
//           prefixStyle: prefixStyle ??
//               TextStyle(
//                 fontSize: prefixTextSize ?? textSize,
//                 color: prefixTextColor ?? textColor,
//               ),
//           suffixStyle: postFixStyle ??
//               TextStyle(
//                 fontSize: postFixTextSize ?? textSize,
//                 color: postFixTextColor ?? textColor,
//               ),
//           filled: fillColor != null || Static.txtInputFilledColor != null,
//           fillColor: fillColor ?? Static.txtInputFilledColor,
//           counterText: hasCounter ? null : "",
//           contentPadding: contentPadding ??
//               EdgeInsets.symmetric(
//                 horizontal: 12,
//                 vertical: (height != null ? (height! - (textSize ?? 16)) / 2 : 12),
//               ),
//         ));
//
//     return TextFormField(
//       controller: controller,
//       showCursor: showCursor,
//       maxLines: isPassword ? 1 : maxLines,
//       minLines: minLines,
//       readOnly: readOnly ?? false,
//       maxLength: maxLength,
//       inputFormatters: inputFormatters,
//       textAlign: textAlign,
//       textCapitalization: textCapitalization,
//       style: style ?? Static.txtInputStyle ??
//           TextStyle(
//             fontSize: textSize ?? Static.txtInputFontSize ?? 16,
//             color: textColor ?? Static.txtInputColor ?? Clr.colorTxt,
//             fontFamily: fontFamily ?? Static.txtInputFontFamily,
//           ),
//       obscureText: isPassword,
//       cursorColor: cursorColor ?? Static.txtInputCursorColor,
//       keyboardType: keyboardType,
//       onChanged: onChanged,
//       textInputAction: textInputAction,
//       onEditingComplete: onEditingComplete,
//       focusNode: focusNode,
//       autofocus: autofocus,
//       onTap: onTap,
//       decoration: effectiveDecoration,
//       enabled: enabled,
//       validator: isOptional
//           ? null
//           : (validator ??
//               (value) {
//             if (value == null || value.isEmpty) {
//               return errorMessage ??
//                   ((appDirectionLeftToRight ?? true)
//                       ? "Please enter $hintText"
//                       : "$hintText Please enter");
//             }
//             if (validationLength != null && value.length < validationLength!) {
//               return errorLengthMessage ??
//                   "At least $validationLength characters required";
//             }
//             if (validationConditionAddOn != null) {
//               return validationConditionAddOn!();
//             }
//             return null;
//           }),
//     );
//   }
//
//   InputBorder _buildBorder({Color? color}) {
//     switch (borderType??(Static.txtInputBorderType)??TxtInputBorderType.outline) {
//       case TxtInputBorderType.none:
//         return InputBorder.none;
//
//       case TxtInputBorderType.underline:
//         return UnderlineInputBorder(
//           borderSide: BorderSide(
//             width: borderWidth,
//             color: color ?? borderColor ?? Clr.colorGreyLight,
//           ),
//         );
//
//       case TxtInputBorderType.outline:
//       return OutlineInputBorder(
//           borderRadius:
//           borderRadius ?? BorderRadius.circular(radius ?? Siz.defaultRadius),
//           borderSide: borderSide ??
//               BorderSide(
//                 width: borderWidth,
//                 color: color ?? borderColor ?? Clr.colorGreyLight,
//               ),
//         );
//     }
//   }
// }

// This file is part of a Flutter package created by Bilal MurtaZa.
// Purpose: This file contains input.




enum TxtInputBorderType {
  none,
  underline,
  outline,
}

class TxtFormInput extends StatefulWidget {
  final TextEditingController? controller;
  final String? errorMessage, hintText, labelText, prefixText;
  final String? errorLengthMessage;
  final String? fontFamily;
  final int? maxLines, minLines, maxLength, validationLength;
  final double? textSize, hintTextSize, radius, prefixTextSize, postFixTextSize, height;
  final double borderWidth;
  final BorderRadius? borderRadius;
  final Color? textColor, hintTextColor, prefixTextColor, postFixTextColor;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign textAlign;
  final TextCapitalization textCapitalization;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final double? labelPadding;
  final bool isPassword;
  final bool enabled;
  final bool isOptional;
  final bool autofocus;
  final bool hasCounter;
  final bool? showCursor;
  final bool? hasLabel, showLabelStar, hasLabelOnTop;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplete;
  final FocusNode? focusNode;
  final Widget? postFix, preFix;
  final InputDecoration? decoration;
  final FormFieldValidator<String>? validator;
  final GlobalKey<FormState>? formKey;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor, borderColor, cursorColor;
  final TextStyle? labelStyle, hintStyle, style, prefixStyle, postFixStyle;
  final BorderSide? borderSide;
  final bool? appDirectionLeftToRight;
  final bool? readOnly;
  final String? Function()? validationConditionAddOn;
  final double errorHeight;
  final TxtInputBorderType? borderType;

  const TxtFormInput({
    super.key,
    this.controller,
    this.errorMessage,
    this.errorLengthMessage,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.inputFormatters,
    this.textAlign = TextAlign.start,
    this.textCapitalization = TextCapitalization.sentences,
    this.textSize,
    this.hintTextSize,
    this.textColor,
    this.onChanged,
    this.onTap,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.onEditingComplete,
    this.focusNode,
    this.hintText = '',
    this.hintTextColor,
    this.enabled = true,
    this.hasLabel,
    this.hasLabelOnTop,
    this.showLabelStar,
    this.postFix,
    this.preFix,
    this.postFixStyle,
    this.decoration,
    this.validator,
    this.formKey,
    this.isOptional = false,
    this.validationLength,
    this.labelText,
    this.labelPadding,
    this.radius,
    this.borderRadius,
    this.contentPadding,
    this.fillColor,
    this.borderColor,
    this.borderWidth = 2,
    this.autofocus = false,
    this.prefixText,
    this.prefixTextSize,
    this.postFixTextSize,
    this.prefixTextColor,
    this.postFixTextColor,
    this.height,
    this.labelStyle,
    this.hintStyle,
    this.style,
    this.prefixStyle,
    this.hasCounter = false,
    this.borderSide,
    this.appDirectionLeftToRight,
    this.showCursor,
    this.readOnly,
    this.validationConditionAddOn,
    this.cursorColor,
    this.errorHeight = 23,
    this.fontFamily,
    this.borderType,
  });

  @override
  State<TxtFormInput> createState() => _TxtFormInputState();
}

class _TxtFormInputState extends State<TxtFormInput> {
  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    return _buildTxtInput();
  }

  Widget _buildTxtInput() {
    return Container(
      color: Clr.colorTransparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.hasLabelOnTop ?? Static.txtInputHasLabelOnTop??false) ...[
            if (widget.hasLabel ?? Static.txtInputHasLabel??false)
              Text.rich(
                TextSpan(
                  text: widget.labelText ?? widget.hintText,
                  children: [
                    if (widget.showLabelStar??false)
                      TextSpan(
                        text: widget.isOptional ? '' : ' *',
                        style: TextStyle(
                          color: Colors.red,
                          fontFamily: widget.fontFamily ??
                              Static.txtInputFontFamily ??
                              Static.fontFamily,
                        ),
                      ),
                  ],
                  style: widget.labelStyle ??
                      Static.labelInputStyle ??
                      TextStyle(
                        fontFamily: widget.fontFamily ??
                            Static.txtInputFontFamily ??
                            Static.fontFamily,
                        color: widget.hintTextColor,
                        fontSize: widget.hintTextSize ?? widget.textSize,
                      ),
                ),
              ),
            MyDivider(height: widget.labelPadding ?? Static.labelPadding ?? 1),
          ],
          SizedBox(
            height: widget.height == null
                ? null
                : hasError
                ? widget.height! + widget.errorHeight
                : widget.height,
            child: TextFormField(
              controller: widget.controller,
              showCursor: widget.showCursor,
              maxLines: widget.isPassword ? 1 : widget.maxLines,
              minLines: widget.minLines,
              readOnly: widget.readOnly ?? false,
              maxLength: widget.maxLength,
              inputFormatters: widget.inputFormatters,
              textAlign: widget.textAlign,
              textCapitalization: widget.textCapitalization,
              style: widget.style ??
                  Static.styleInput ??
                  TextStyle(
                    fontSize: widget.textSize,
                    color: widget.textColor ?? Clr.colorTxt,
                    fontFamily: widget.fontFamily ??
                        Static.txtInputFontFamily ??
                        Static.fontFamily,
                  ),
              obscureText: widget.isPassword,
              cursorColor: widget.cursorColor,
              keyboardType: widget.keyboardType,
              onChanged: widget.onChanged,
              textInputAction: widget.textInputAction,
              onEditingComplete: widget.onEditingComplete,
              focusNode: widget.focusNode,
              autofocus: widget.autofocus,
              onTap: widget.onTap,
              decoration: widget.decoration ??
                  _buildInputDecoration(context),
              validator: widget.isOptional
                  ? null
                  : (widget.validator ?? _defaultValidator),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _buildInputDecoration(BuildContext context) {
    final borderRadius = widget.borderRadius ??
        BorderRadius.circular(widget.radius ?? Siz.defaultRadius);

    OutlineInputBorder outlineBorder = OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: BorderSide(
        width: widget.borderWidth,
        color: widget.borderColor ?? Static.borderColor ?? Clr.colorGreyLight,
      ),
    );

    UnderlineInputBorder underlineBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        width: widget.borderWidth,
        color: widget.borderColor ?? Static.borderColor ?? Clr.colorGreyLight,
      ),
    );

    InputBorder getBorder() {
      switch (widget.borderType ?? Static.txtInputBorderType ?? TxtInputBorderType.outline) {
        case TxtInputBorderType.none:
          return InputBorder.none;
        case TxtInputBorderType.underline:
          return underlineBorder;
        case TxtInputBorderType.outline:
          return outlineBorder;
      }
    }

    return InputDecoration(
      hintText: widget.hintText,
      hintStyle: widget.hintStyle ??
          TextStyle(
            fontSize: widget.hintTextSize ?? widget.textSize,
            color: widget.hintTextColor,
            fontFamily:
            widget.fontFamily ?? Static.txtInputFontFamily ?? Static.fontFamily,
          ),
      labelStyle: widget.labelStyle ?? Static.labelInputStyle,
      suffixIcon: widget.postFix,
      prefixIcon: widget.preFix,
      counterText: widget.hasCounter ? null : '',
      enabled: widget.enabled,
      contentPadding: widget.contentPadding ??
          (Static.txtInoutDefaultContentPadding),
      fillColor: widget.fillColor,
      filled: widget.fillColor != null,
      prefixText: widget.prefixText,
      prefixStyle: widget.prefixStyle,
      border: getBorder(),
      enabledBorder: getBorder(),
      focusedBorder: getBorder(),
      errorBorder: getBorder(),
    );
  }

  String? _defaultValidator(String? value) {
    setState(() => hasError = true);
    if (value == null || value.isEmpty) {
      return widget.errorMessage ??
          ((widget.appDirectionLeftToRight ??
              Static.appDirectionLeftToRight ??
              true)
              ? 'Please Enter ${widget.hintText}'
              : '${widget.hintText} Please Enter')
              ;
    }
    if (widget.validationLength != null &&
        value.length < widget.validationLength!) {
      return widget.errorLengthMessage ??
          'At least ${widget.validationLength} character required';
    }
    setState(() => hasError = false);

    if (widget.validationConditionAddOn != null) {
      final response = widget.validationConditionAddOn!();
      if (response != null) return response;
    }
    return null;
  }
}

