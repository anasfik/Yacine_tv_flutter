import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class MatchTimeInfo extends StatelessWidget {
  const MatchTimeInfo({
    super.key,
    required this.date,
  });

  final DateTime date;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.175),
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      ),
      child: AutoSizeText(
        date.timeFormatted(),
        style: Theme.of(context).textTheme.subtitle1?.copyWith(
              fontSize: 17.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

extension TimeFormattedExtension on DateTime {
  String timeFormatted() {
    final padLeftedhour = hour.toString().padLeft(2, '0');
    final padLeftedminute = minute.toString().padLeft(2, '0');

    return "$padLeftedhour:$padLeftedminute";
  }
}
