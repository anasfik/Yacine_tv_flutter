import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBarText(
    String text,
  ) {
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  Future push(Widget widget) => Navigator.of(this).push(
        MaterialPageRoute(
          builder: (context) => widget,
        ),
      );

  void pop() => Navigator.of(this).pop();
}
