import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum RouteType { push, pushReplace, pushRemoveUntil, pushReplaceAll }

Future<dynamic> pSetRout({
  required dynamic page,
  RouteType routeType = RouteType.push,
  bool fullscreenDialog = false,
  BuildContext? context,
  Duration? duration,
  Curve? curve,
  Transition? transition,
  bool? opaque,
  int? id,
  String? routeName,
  dynamic arguments,
  Bindings? binding,
  bool preventDuplicates = true,
  bool? popGesture,
  double Function(BuildContext context)? gestureWidth,
  RoutePredicate? predicate,
}) async {
  switch (routeType) {
    case RouteType.push:
      return Get.to(
        page,
        fullscreenDialog: fullscreenDialog,
        duration: duration,
        curve: curve,
        transition: transition,
        preventDuplicates: preventDuplicates,
        routeName: routeName,
        arguments: arguments,
        binding: binding,
        gestureWidth: gestureWidth,
        id: id,
        opaque: opaque,
        popGesture: popGesture,
      );
    case RouteType.pushReplace:
      return Get.off(
        page,
        fullscreenDialog: fullscreenDialog,
        duration: duration,
        curve: curve,
        transition: transition,
        preventDuplicates: preventDuplicates,
        routeName: routeName,
        arguments: arguments,
        binding: binding,
        gestureWidth: gestureWidth,
        id: id,
        opaque: opaque??false,
        popGesture: popGesture,
      );
    case RouteType.pushReplaceAll:
      return Get.offAll(
        page,
        fullscreenDialog: fullscreenDialog,
        duration: duration,
        curve: curve,
        transition: transition,
        routeName: routeName,
        arguments: arguments,
        binding: binding,
        gestureWidth: gestureWidth,
        id: id,
        opaque: opaque??false,
        popGesture: popGesture,
        predicate: predicate,
      );
    case RouteType.pushRemoveUntil:
      return Navigator.pushAndRemoveUntil(
        context ?? Get.context!,
        MaterialPageRoute(
          builder: (context) => page,
          fullscreenDialog: fullscreenDialog,
        ),
            (route) => false,
      );
  }
}
