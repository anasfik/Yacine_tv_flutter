import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:web_panel/core/extension/string.dart';

class AdditionalInfo extends StatelessWidget {
  const AdditionalInfo({
    super.key,
    required this.icon,
    required this.text,
  });

  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AutoSizeText(
          text.capitalizeAllWordsFirstLetter(),
          maxLines: 1,
        ),
        const SizedBox(width: 5),
        Icon(
          icon,
          color: Colors.grey,
          size: 20,
        ),
      ],
    );
  }
}
