import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:web_panel/core/extension/date.dart';

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
        Text(
          "Choose date and time",
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
        ),
        // const Spacer(),
        Row(
          children: [
            IconButton(
              onPressed: onPressed,
              icon: const Icon(FlutterRemix.calendar_2_fill),
            ),
            Text(date.formattedForHumans()),
          ],
        ),
      ],
    );
  }
}
