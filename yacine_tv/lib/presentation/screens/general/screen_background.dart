import 'package:flutter/material.dart';

import '../../../config/general.dart';

class ScreenBackground extends StatelessWidget {
  const ScreenBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Configs.backgroundAsset,
      fit: BoxFit.cover,
    );
  }
}
