import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

class DateTimeSelect extends StatelessWidget {
  const DateTimeSelect({
    super.key,
    required this.date,
    required this.onPressed,
  });

  final DateTime date;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        AutoSizeText(
          date.toString(),
        ),
        IconButton(
          onPressed: onPressed,
          icon: const Icon(FlutterRemix.calendar_2_fill),
        )
      ],
    );
  }
}
