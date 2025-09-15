import 'package:flutter/material.dart';
import '../utils/utils.dart';

void pSnackBar({
  required BuildContext context,
  String title = 'Info',
  required String? message,
  Color colorText = Clr.colorWhite,
  Color? backgroundColor,
  Color? borderColor,
  bool isError = false,
  Duration? duration,

  bool showDefaultIcon = true,
  IconData? customIcon,
  Color? customIconColor,
  ImageProvider? image, // use if you want image instead of icon
}) {
  Widget? leading;

  // Decide what to show (icon / image / nothing)
  if (image != null) {
    leading = CircleAvatar(
      backgroundImage: image,
      radius: 14,
    );
  } else if (customIcon != null) {
    leading = Icon(customIcon, color: customIconColor ?? Colors.white);
  } else if (showDefaultIcon) {
    leading = Icon(
      isError ? Icons.error : Icons.info,
      color: Colors.white,
    );
  }

  final snackBar = SnackBar(
    backgroundColor: isError ? Colors.red : backgroundColor ?? Clr.colorPrimary,
    duration: duration ?? const Duration(seconds: 3),
    content: Row(
      children: [
        if (leading != null) ...[
          leading,
          const SizedBox(width: 8),
        ],
        Expanded(
          child: Text(
            "${isError ? 'Error' : title}: ${message ?? ''}",
            style: TextStyle(color: colorText),
          ),
        ),
      ],
    ),
    behavior: SnackBarBehavior.floating,
    shape: borderColor != null
        ? RoundedRectangleBorder(
      side: BorderSide(color: borderColor, width: 2),
      borderRadius: BorderRadius.circular(8),
    )
        : null,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
