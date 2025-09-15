import 'package:flutter/material.dart';

enum RouteType { push, pushReplace, pushRemoveUntil, pushReplaceAll }

Future<dynamic> pSetRout({
  required Widget page,
  required BuildContext context,
  RouteType routeType = RouteType.push,
  bool fullscreenDialog = false,
  RoutePredicate? predicate,
}) async {
  final route = MaterialPageRoute(
    builder: (context) => page,
    fullscreenDialog: fullscreenDialog,
  );

  switch (routeType) {
    case RouteType.push:
      return Navigator.push(context, route);

    case RouteType.pushReplace:
      return Navigator.pushReplacement(context, route);

    case RouteType.pushReplaceAll:
      return Navigator.pushAndRemoveUntil(context, route, (route) => false);

    case RouteType.pushRemoveUntil:
      return Navigator.pushAndRemoveUntil(
        context,
        route,
        predicate ?? (route) => false,
      );
  }
}
