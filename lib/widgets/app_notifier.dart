import 'package:flutter/material.dart';

class AppNotifier {
  /// Show a simple Snackbar
  static void showSnackBar(
      BuildContext context, {
        required String message,
        Color backgroundColor = Colors.black87,
        Color textColor = Colors.white,
        Duration duration = const Duration(seconds: 8),
        SnackBarAction? action,
      }) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: textColor),
      ),
      backgroundColor: backgroundColor,
      duration: duration,
      action: action,
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  /// Show a lightweight Toast-like overlay (no context needed)
  static void showToast(
      BuildContext context, {
        required String message,
        Color backgroundColor = Colors.white,
        Color textColor = Colors.black,
        Duration duration = const Duration(seconds: 8),
        double borderRadius = 8,
        EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      }) {
    final overlay = Overlay.of(context);

    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 80,
        left: 24,
        right: 24,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Center(
              child: Text(
                message,
                style: TextStyle(color: textColor),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(duration, () {
      overlayEntry.remove();
    });
  }
}
