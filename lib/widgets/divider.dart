import 'package:flutter/material.dart';

/// A reusable vertical divider with customizable width, color, and thickness.
class MyVerticalDivider extends StatelessWidget {
  final double width;
  final double? thickness;
  final Color color;
  final double? indent;
  final double? endIndent;

  const MyVerticalDivider({
    this.width = 16.0, // sensible default
    this.color = Colors.grey,
    this.thickness,
    this.indent,
    this.endIndent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      width: width,
      color: color,
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
    );
  }
}

/// A reusable horizontal divider with customizable height, color, and thickness.
class MyDivider extends StatelessWidget {
  final double height;
  final double? thickness;
  final Color color;
  final double? indent;
  final double? endIndent;

  const MyDivider({
    this.height = 16.0, // sensible default
    this.color = Colors.grey,
    this.thickness,
    this.indent,
    this.endIndent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      color: color,
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
    );
  }
}
