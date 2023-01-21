import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  // ignore: format-comment
  /// This function displays a SnackBar with a given message.
  ///
  /// It returns a [ScaffoldFeatureController] which can be used to interact with the SnackBar.
  ///
  /// ## Example
  /// ```dart
  /// final snackBarController = context.snackBarText('Hello World!');
  /// ```
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBarText(
    String message,
  ) {
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  // ignore: format-comment
  /// This function pushes a new screen onto the Navigator's stack.
  ///
  /// It takes a [Widget] screen as the argument, which represents the screen that should be pushed onto the Navigator's stack.
  ///
  /// ## Example
  /// ```dart
  /// context.navigatorPush(MyScreen());
  /// ```
  void navigatorPush(Widget screen) => Navigator.of(this).push(
        MaterialPageRoute(
          builder: (context) => screen,
        ),
      );
}
