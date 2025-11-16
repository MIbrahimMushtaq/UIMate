import 'dart:ui' as ui show TextHeightBehavior;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

enum TrimMode { Length, Line }

@immutable
class Annotation {
  const Annotation({
    required this.regExp,
    required this.spanBuilder,
  });

  final RegExp regExp;
  final TextSpan Function({required String text, required TextStyle textStyle})
  spanBuilder;
}

class ReadMoreTxt extends StatefulWidget {
  const ReadMoreTxt(
      this.data, {
        super.key,
        this.isCollapsed,
        this.preDataText,
        this.postDataText,
        this.preDataTextStyle,
        this.postDataTextStyle,
        this.trimExpandedText = 'show less',
        this.trimCollapsedText = 'read more',
        this.colorClickableText,
        this.trimLength = 240,
        this.trimLines = 2,
        this.trimMode = TrimMode.Length,
        this.moreStyle,
        this.lessStyle,
        this.delimiter = '$_kEllipsis ',
        this.delimiterStyle,
        this.annotations,
        this.isExpandable = true,
        this.style,
        this.strutStyle,
        this.textAlign,
        this.textDirection,
        this.locale,
        this.softWrap,
        this.overflow,
        this.textScaler,
        this.semanticsLabel,
        this.textWidthBasis,
        this.textHeightBehavior,
        this.selectionColor,

        /// NEW — custom widgets
        this.customCollapsedWidget,
        this.customExpandedWidget,
      })  : richData = null,
        richPreData = null,
        richPostData = null;

  const ReadMoreTxt.rich(
      this.richData, {
        super.key,
        this.richPreData,
        this.richPostData,
        this.isCollapsed,
        this.trimExpandedText = 'show less',
        this.trimCollapsedText = 'read more',
        this.colorClickableText,
        this.trimLength = 240,
        this.trimLines = 2,
        this.trimMode = TrimMode.Length,
        this.moreStyle,
        this.lessStyle,
        this.delimiter = '$_kEllipsis ',
        this.delimiterStyle,
        this.isExpandable = true,
        this.style,
        this.strutStyle,
        this.textAlign,
        this.textDirection,
        this.locale,
        this.softWrap,
        this.overflow,
        this.textScaler,
        this.semanticsLabel,
        this.textWidthBasis,
        this.textHeightBehavior,
        this.selectionColor,

        /// NEW — custom widgets
        this.customCollapsedWidget,
        this.customExpandedWidget,
      })  : data = null,
        annotations = null,
        preDataText = null,
        postDataText = null,
        preDataTextStyle = null,
        postDataTextStyle = null;

  final ValueNotifier<bool>? isCollapsed;
  final int trimLength;
  final int trimLines;
  final TrimMode trimMode;
  final TextStyle? moreStyle;
  final TextStyle? lessStyle;

  final String? preDataText;
  final String? postDataText;
  final TextStyle? preDataTextStyle;
  final TextStyle? postDataTextStyle;

  final TextSpan? richPreData;
  final TextSpan? richPostData;

  final List<Annotation>? annotations;
  final bool isExpandable;
  final String delimiter;

  final String? data;
  final TextSpan? richData;
  final String trimExpandedText;
  final String trimCollapsedText;
  final Color? colorClickableText;
  final TextStyle? delimiterStyle;

  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final TextScaler? textScaler;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final ui.TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;

  /// NEW — User can pass any widget for show more / show less
  final Widget? customCollapsedWidget;
  final Widget? customExpandedWidget;

  @override
  State<ReadMoreTxt> createState() => ReadMoreTxtState();
}

const String _kEllipsis = '\u2026';
const String _kLineSeparator = '\u2028';

class ReadMoreTxtState extends State<ReadMoreTxt> {
  final TapGestureRecognizer _recognizer = TapGestureRecognizer();
  ValueNotifier<bool>? _isCollapsed;

  ValueNotifier<bool> get _effectiveIsCollapsed =>
      widget.isCollapsed ?? (_isCollapsed ??= ValueNotifier(true));

  @override
  void initState() {
    super.initState();
    _recognizer.onTap = _onTap;
  }

  @override
  void dispose() {
    _recognizer.dispose();
    _isCollapsed?.dispose();
    super.dispose();
  }

  void _onTap() {
    if (widget.isExpandable) {
      _effectiveIsCollapsed.value = !_effectiveIsCollapsed.value;
    }
  }

  /// NEW — builds custom or default show more/less
  InlineSpan _buildLinkSpan(bool isCollapsed, TextStyle textStyle) {
    // Case: custom collapsed widget → "Read more"
    if (isCollapsed && widget.customCollapsedWidget != null) {
      return WidgetSpan(
        child: GestureDetector(
          onTap: _onTap,
          child: widget.customCollapsedWidget!,
        ),
      );
    }

    // Case: custom expanded widget → "Show less"
    if (!isCollapsed && widget.customExpandedWidget != null) {
      return WidgetSpan(
        child: GestureDetector(
          onTap: _onTap,
          child: widget.customExpandedWidget!,
        ),
      );
    }

    // Fallback to text span
    return TextSpan(
      text: isCollapsed ? widget.trimCollapsedText : widget.trimExpandedText,
      style: isCollapsed
          ? widget.moreStyle ?? textStyle
          : widget.lessStyle ?? textStyle,
      recognizer: _recognizer,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _effectiveIsCollapsed,
      builder: _buildView,
    );
  }

  Widget _buildView(BuildContext context, bool isCollapsed, Widget? child) {
    final defaultStyle = DefaultTextStyle.of(context).style;
    final effectiveStyle = defaultStyle.merge(widget.style);

    final link = _buildLinkSpan(isCollapsed, effectiveStyle);

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;

        // Whole text
        final fullText = TextSpan(
          text: widget.data,
          style: effectiveStyle,
        );

        final tp = TextPainter(
          text: fullText,
          maxLines: isCollapsed ? widget.trimLines : null,
          textDirection: TextDirection.ltr,
        );

        tp.layout(maxWidth: maxWidth);

        final didTrim = tp.didExceedMaxLines;

        if (!didTrim || !isCollapsed) {
          // Expanded → add link at bottom
          return RichText(
            text: TextSpan(
              children: [
                fullText,
                const TextSpan(text: " "),
                link,
              ],
            ),
          );
        }

        // Collapsed → trim lines
        final endIndex = tp.getPositionForOffset(
          Offset(tp.width, tp.height),
        ).offset;

        final trimmedText = widget.data!.substring(0, endIndex);

        return RichText(
          text: TextSpan(
            children: [
              TextSpan(text: trimmedText, style: effectiveStyle),
              const TextSpan(text: " "),
              link,
            ],
          ),
        );
      },
    );
  }
}
