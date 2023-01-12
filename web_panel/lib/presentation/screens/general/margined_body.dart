import 'package:flutter/material.dart';

class MarginedBody extends StatelessWidget {
  const MarginedBody({
    super.key,
    this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
  });

  final Widget? child;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: child,
    );
  }
}

class MarginedBodyForInputs extends MarginedBody {
  const MarginedBodyForInputs({
    super.key,
    super.padding = const EdgeInsets.symmetric(
      horizontal: 40,
      vertical: 40,
    ),
    super.child,
  });
}
