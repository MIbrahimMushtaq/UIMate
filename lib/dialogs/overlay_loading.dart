import 'package:flutter/material.dart';
import '../widgets/loader.dart';

class LoadingOverlay {
  static OverlayEntry? _overlayEntry;
  static bool _isShowing = false;

  static void show(
      BuildContext context, {
        Widget? body,
        bool dismissible = false,
        Color backgroundColor = const Color(0x66000000),
      }) {
    if (_isShowing) return;
    _isShowing = true;

    _overlayEntry = OverlayEntry(
      builder: (_) => GestureDetector(
        onTap: dismissible ? () => hide() : null,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: Container(color: backgroundColor),
            ),

            _AnimatedDialogBody(
              child: body ??
                  const SizedBox(
                    height: 100,
                    width: 100,
                    child: LoadingPro(), // your spinner widget
                  ),
            ),
          ],
        ),
      ),
    );

    Overlay.of(context, rootOverlay: true).insert(_overlayEntry!);
  }

  static void hide() {
    if (!_isShowing) return;
    _overlayEntry?.remove();
    _overlayEntry = null;
    _isShowing = false;
  }
}

class _AnimatedDialogBody extends StatefulWidget {
  final Widget child;

  const _AnimatedDialogBody({required this.child});

  @override
  State<_AnimatedDialogBody> createState() => _AnimatedDialogBodyState();
}

class _AnimatedDialogBodyState extends State<_AnimatedDialogBody>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scale = CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: Material(
        color: Colors.transparent,
        child: widget.child,
      ),
    );
  }
}
