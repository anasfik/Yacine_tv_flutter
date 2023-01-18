import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBarText(
    String message,
  ) {
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void navigatorPush(Widget screen) => Navigator.of(this).push(
        MaterialPageRoute(
          builder: (context) => screen,
        ),
      );
}
