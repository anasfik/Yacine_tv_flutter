import 'package:flutter/material.dart';

import '../../../core/lang/en.dart';

class EmptinessWidget extends StatelessWidget {
  const EmptinessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(L10n.noElementsCategoriesFound),
    );
  }
}
