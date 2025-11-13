import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_mate/global_config/text_input_config.dart';

enum TxtInputBorderType { none, underline, outline }

class TxtFormInput extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final bool isPassword;
  final bool enabled;
  final bool autofocus;
  final bool readOnly;
  final bool isOptional;

  final int? maxLength, maxLines, minLines, validationLength;
  final Color? borderColor;
  final Color? cursorColor;
  final Color? fillColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final TxtInputBorderType? borderType;
  final String? errorMessage, errorLengthMessage;
  final String? Function()? validationConditionAddOn;
  final double? height;

  // Text styles
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

  final double? labelPadding;
  final TextStyle? style;
  final TextAlign textAlign;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? preFix, postFix;
  final bool showCursor;

  const TxtFormInput({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.isPassword = false,
    this.enabled = true,
    this.autofocus = false,
    this.readOnly = false,
    this.isOptional = false,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.validationLength,
    this.borderColor,
    this.cursorColor,
    this.fillColor,
    this.borderWidth,
    this.borderRadius,
    this.contentPadding,
    this.borderType,
    this.errorMessage,
    this.errorLengthMessage,
    this.validationConditionAddOn,
    this.height,
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
    this.labelPadding,
    this.style,
    this.textAlign = TextAlign.start,
    this.onChanged,
    this.onTap,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.onEditingComplete,
    this.inputFormatters,
    this.preFix,
    this.postFix,
    this.showCursor = true,
  });

  @override
  State<TxtFormInput> createState() => _TxtFormInputState();
}

class _TxtFormInputState extends State<TxtFormInput> {
  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    final config = TxtFormInputConfig.global;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if ((widget.labelText ?? '').isNotEmpty)
          Padding(
            padding: EdgeInsets.only(
              bottom: widget.labelPadding ?? config.labelPadding ?? 6,
            ),
            child: Text(
              widget.labelText!,
              style: TextStyle(
                fontFamily: widget.labelFontFamily ??
                    config.labelFontFamily ??
                    widget.fontFamily ??
                    config.fontFamily,
                color: widget.labelTextColor ??
                    config.labelTextColor ??
                    Colors.black87,
                fontSize:
                widget.labelTextSize ?? config.labelTextSize ?? 15,
                fontStyle:
                widget.labelFontStyle ?? config.labelFontStyle,
                fontWeight: widget.labelFontWeight ??
                    config.labelFontWeight ??
                    FontWeight.w500,
              ),
            ),
          ),
        SizedBox(
          height: widget.height ?? config.height,
          child: TextFormField(
            controller: widget.controller,
            showCursor: widget.showCursor,
            obscureText: widget.isPassword,
            enabled: widget.enabled,
            autofocus: widget.autofocus,
            readOnly: widget.readOnly,
            maxLength: widget.maxLength,
            maxLines: widget.isPassword ? 1 : widget.maxLines,
            minLines: widget.minLines,
            inputFormatters: widget.inputFormatters,
            textAlign: widget.textAlign,
            style: widget.style ??
                TextStyle(
                  fontFamily: widget.fontFamily ?? config.fontFamily,
                  fontSize: widget.hintTextSize ??
                      config.hintTextSize ??
                      15,
                  color: widget.labelTextColor ??
                      config.labelTextColor ??
                      Colors.black,
                ),
            onChanged: widget.onChanged,
            onTap: widget.onTap,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            onEditingComplete: widget.onEditingComplete,
            focusNode: widget.focusNode,
            cursorColor:
            widget.cursorColor ?? config.cursorColor ?? Colors.black,
            decoration: _buildInputDecoration(),
            validator: widget.isOptional ? null : _defaultValidator,
          ),
        ),
      ],
    );
  }

  InputDecoration _buildInputDecoration() {
    final config = TxtFormInputConfig.global;
    final TxtInputBorderType borderType =
        widget.borderType ?? config.borderType ?? TxtInputBorderType.outline;

    OutlineInputBorder outlineBorder = OutlineInputBorder(
      borderRadius: widget.borderRadius ??
          config.borderRadius ??
          BorderRadius.circular(8),
      borderSide: BorderSide(
        color: widget.borderColor ??
            config.borderColor ??
            Colors.grey.shade400,
        width: widget.borderWidth ?? config.borderWidth ?? 1.2,
      ),
    );

    UnderlineInputBorder underlineBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        color: widget.borderColor ??
            config.borderColor ??
            Colors.grey.shade400,
        width: widget.borderWidth ?? config.borderWidth ?? 1.2,
      ),
    );

    InputBorder getBorder() {
      switch (borderType) {
        case TxtInputBorderType.none:
          return InputBorder.none;
        case TxtInputBorderType.underline:
          return underlineBorder;
        case TxtInputBorderType.outline:
        default:
          return outlineBorder;
      }
    }

    return InputDecoration(
      hintText: widget.hintText,
      hintStyle: TextStyle(
        fontFamily: widget.hintFontFamily ??
            config.hintFontFamily ??
            widget.fontFamily ??
            config.fontFamily,
        color:
        widget.hintTextColor ?? config.hintTextColor ?? Colors.grey,
        fontSize:
        widget.hintTextSize ?? config.hintTextSize ?? 14,
        fontStyle: widget.hintFontStyle ?? config.hintFontStyle,
        fontWeight: widget.hintFontWeight ??
            config.hintFontWeight ??
            FontWeight.normal,
      ),
      prefixIcon: widget.preFix,
      suffixIcon: widget.postFix,
      filled: true,
      fillColor: widget.fillColor ?? config.fillColor ?? Colors.grey.shade100,
      border: getBorder(),
      enabledBorder: getBorder(),
      focusedBorder: getBorder(),
      contentPadding: widget.contentPadding ??
          const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      counterText: '',
    );
  }

  String? _defaultValidator(String? value) {
    setState(() => hasError = true);
    if (value == null || value.isEmpty) {
      return widget.errorMessage ?? 'Please enter ${widget.labelText ?? ''}';
    }
    if (widget.validationLength != null &&
        value.length < widget.validationLength!) {
      return widget.errorLengthMessage ??
          'At least ${widget.validationLength} characters required';
    }
    setState(() => hasError = false);
    if (widget.validationConditionAddOn != null) {
      final res = widget.validationConditionAddOn!();
      if (res != null) return res;
    }
    return null;
  }
}
