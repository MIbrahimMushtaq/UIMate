import 'package:flutter/material.dart';
import 'focus.dart';

enum RouteType { push, pushReplace, pushRemoveUntil, pushReplaceAll }

Future<dynamic> pSetRout({
  required dynamic page,
  RouteType routeType = RouteType.push,
  bool fullscreenDialog = false,
  BuildContext? context,
  Duration? duration,
  Curve? curve,
  bool preventDuplicates = true,
  bool? opaque,
  String? routeName,
  dynamic arguments,
  RoutePredicate? predicate,
}) async {
  pFocusOut(context: context!);

  final ctx = context;

  Widget pageWidget = page is Widget ? page : page();

  final route = PageRouteBuilder(
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => pageWidget,
    settings: RouteSettings(
      name: routeName,
      arguments: arguments,
    ),
    fullscreenDialog: fullscreenDialog,
    opaque: opaque ?? true,
    transitionDuration: duration ?? const Duration(milliseconds: 300),
    transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
      final curved = curve != null ? CurvedAnimation(parent: animation, curve: curve) : animation;
      return FadeTransition(opacity: curved, child: child);
    },
  );


  switch (routeType) {
    case RouteType.push:
      return Navigator.push(ctx, route);
    case RouteType.pushReplace:
      return Navigator.pushReplacement(ctx, route);
    case RouteType.pushReplaceAll:
      return Navigator.pushAndRemoveUntil(ctx, route, predicate ?? (route) => false);
    case RouteType.pushRemoveUntil:
      return Navigator.pushAndRemoveUntil(ctx, route, (route) => false);
  }
}


