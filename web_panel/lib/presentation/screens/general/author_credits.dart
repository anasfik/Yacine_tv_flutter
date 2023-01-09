import 'package:flutter/material.dart';

class AuthorCredits extends StatelessWidget {
  const AuthorCredits({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const Spacer(),
        Text(
          'Developed by',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(width: 5),
        Text(
          'Gwhyyy',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor,
              ),
        ),
        const SizedBox(width: 5),
        Text(
          '© ${DateTime.now().year}',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        const Spacer(),
      ],
    );
  }
}
