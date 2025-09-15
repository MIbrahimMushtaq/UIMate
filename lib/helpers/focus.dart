import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

pFocusOut({BuildContext? context, bool isHide = true, FocusNode? focusNode}) {
  FocusScope.of(context ?? Get.context!).requestFocus(focusNode ?? FocusNode());
  if (!isHide) {
    return SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}
