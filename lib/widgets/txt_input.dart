import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/utils.dart';

class TxtFormInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? errorMessage, hintText, labelText, prefixText;
  final String? errorLengthMessage;
  final String? fontFamily;
  final int? maxLines, minLines, maxLength, validationLength;
  final double? textSize, hintTextSize, radius, prefixTextSize, postFixTextSize;
  final double borderWidth;
  final BorderRadius? borderRadius;
  final Color? textColor, hintTextColor, prefixTextColor, postFixTextColor;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign textAlign;
  final TextCapitalization textCapitalization;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final bool isPassword;
  final bool enabled;
  final bool isOptional;
  final bool removeAllBorders;
  final bool autofocus;
  final bool hasCounter;
  final bool? showCursor;
  final bool? hasBorder, hasLabel, showLabelStar, hasLabelOnTop;
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
  final double? height;

  const TxtFormInput({
    super.key,
    this.controller,
    this.errorMessage,
    this.errorLengthMessage,
    this.maxLines = 1,
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
    this.hasBorder,
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
    this.radius,
    this.borderRadius,
    this.contentPadding,
    this.fillColor,
    this.borderColor,
    this.borderWidth = 1.2,
    this.autofocus = false,
    this.removeAllBorders = false,
    this.prefixText,
    this.prefixTextSize,
    this.postFixTextSize,
    this.prefixTextColor,
    this.postFixTextColor,
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
    this.fontFamily,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final InputDecoration effectiveDecoration = (decoration ??
        Static.inputDecoration ??
        InputDecoration(
          border: _buildBorder(),
          enabledBorder: _buildBorder(),
          focusedBorder: _buildBorder(color: borderColor ?? Colors.blue),
          errorBorder: _buildBorder(color: Colors.red),
          focusedErrorBorder: _buildBorder(color: Colors.red),
          hintText: hintText,
          hintStyle: hintStyle ??
              TextStyle(
                fontSize: hintTextSize ?? textSize,
                color: hintTextColor ?? Colors.grey,
                fontFamily: fontFamily ?? Static.txtInputFontFamily,
              ),
          prefixIcon: preFix,
          suffixIcon: postFix,
          prefixText: prefixText,
          prefixStyle: prefixStyle ??
              TextStyle(
                fontSize: prefixTextSize ?? textSize,
                color: prefixTextColor ?? textColor,
              ),
          suffixStyle: postFixStyle ??
              TextStyle(
                fontSize: postFixTextSize ?? textSize,
                color: postFixTextColor ?? textColor,
              ),
          filled: fillColor != null,
          fillColor: fillColor,
          counterText: hasCounter ? null : "",
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(
                horizontal: 12,
                vertical: (height != null ? (height! - (textSize ?? 16)) / 2 : 12),
              ), // ✅ keeps text centered
        ));

    return TextFormField(
      controller: controller,
      showCursor: showCursor,
      maxLines: isPassword ? 1 : maxLines,
      minLines: minLines,
      readOnly: readOnly ?? false,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      textAlign: textAlign,
      textCapitalization: textCapitalization,
      style: style ??
          TextStyle(
            fontSize: textSize ?? 16,
            color: textColor ?? Clr.colorTxt,
            fontFamily: fontFamily ?? Static.txtInputFontFamily,
          ),
      obscureText: isPassword,
      cursorColor: cursorColor,
      keyboardType: keyboardType,
      onChanged: onChanged,
      textInputAction: textInputAction,
      onEditingComplete: onEditingComplete,
      focusNode: focusNode,
      autofocus: autofocus,
      onTap: onTap,
      decoration: effectiveDecoration,
      enabled: enabled,
      validator: isOptional
          ? null
          : (validator ??
              (value) {
            if (value == null || value.isEmpty) {
              return errorMessage ??
                  ((appDirectionLeftToRight ?? true)
                      ? "Please enter $hintText"
                      : "$hintText Please enter");
            }
            if (validationLength != null && value.length < validationLength!) {
              return errorLengthMessage ??
                  "At least $validationLength characters required";
            }
            if (validationConditionAddOn != null) {
              return validationConditionAddOn!();
            }
            return null;
          }),
    );
  }

  OutlineInputBorder _buildBorder({Color? color}) {
    return OutlineInputBorder(
      borderRadius:
      borderRadius ?? BorderRadius.circular(radius ?? Siz.defaultRadius),
      borderSide: removeAllBorders
          ? BorderSide.none
          : borderSide ??
          BorderSide(
            width: borderWidth,
            color: color ?? borderColor ?? Clr.colorGreyLight,
          ),
    );
  }
}
