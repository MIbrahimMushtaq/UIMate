import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void pFocusOut({
  required BuildContext context,
  bool isHide = true,
  FocusNode? focusNode,
}) {
  FocusScope.of(context).requestFocus(focusNode ?? FocusNode());
  if (!isHide) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}
