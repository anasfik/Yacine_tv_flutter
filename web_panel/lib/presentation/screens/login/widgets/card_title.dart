import 'dart:html';

import 'package:flutter/material.dart';
import 'package:web_panel/data/providers/l10n/en.dart';

class CardTitle extends StatelessWidget {
  const CardTitle({super.key, required this.text, this.style});

  final String text;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          style: style,
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: getTextSize(text, style).width,
          height: 2,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }
}

Size getTextSize(String text, TextStyle? style) {
  final textPainter = TextPainter(
    text: TextSpan(
      text: text,
      style: style,
    ),
    maxLines: 1,
    textDirection: TextDirection.ltr,
  )..layout();

  return textPainter.size;
}
