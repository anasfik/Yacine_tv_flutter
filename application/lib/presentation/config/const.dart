import 'package:flutter/material.dart';

import '../../core/lang/en.dart';
import '../../data/models/navigation_item.dart';
import '../screens/event_matches/event_matches.dart';
import '../screens/home/home.dart';

class PresentationLayerConstants {
  static const navigationItems = <NavigationItem>[
    NavigationItem(
      icon: Icons.live_tv,
      name: L10n.liveTv,
      screen: Home(),
    ),
    NavigationItem(
      icon: Icons.sports_football,
      name: L10n.matches,
      screen: EventMatches(),
    ),
  ];
}
