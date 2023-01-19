import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:web_panel/data/providers/l10n/en.dart';
import 'package:web_panel/presentation/screens/settings/settings.dart';

import '../../data/models/dashboard_screen.dart';
import '../../presentation/screens/admob_settings/admob_settings.dart';
import '../../presentation/screens/channels_categories/channels_categories.dart';
import '../../presentation/screens/math_events/math_events.dart';
import '../../presentation/screens/menu/menu.dart';

class DashBoardScreensCubit extends Cubit<int> {
  /// List of all screens that will be displayed in the dashboard, their icons titles.
  final List<DashBoardScreen> panels = <DashBoardScreen>[
    const DashBoardScreen(
      title: L10n.channelsCategories,
      screen: ChannelsCategories(title: L10n.channelsCategories),
      icon: FlutterRemix.tv_2_line,
    ),
    const DashBoardScreen(
      title: L10n.mathEvents,
      screen: MathEvents(title: L10n.mathEvents),
      icon: FlutterRemix.football_line,
    ),
    const DashBoardScreen(
      title: L10n.menuBar,
      screen: Menu(title: L10n.menuBar),
      icon: FlutterRemix.menu_3_line,
    ),
    const DashBoardScreen(
      title: L10n.admob,
      screen: AdmobSettings(title: L10n.admob),
      icon: FlutterRemix.advertisement_line,
    ),
    const DashBoardScreen(
      title: L10n.settings,
      screen: Settings(title: L10n.settings),
      icon: FlutterRemix.settings_3_line,
    ),
  ];

  DashBoardScreensCubit(int currentIndex) : super(currentIndex);

  /// This function triggers a screen change to the screen at the given [index].
  void triggerScreenAt(int index) {
    emit(index);
  }

  /// This function triggers the settings screen. It opens the navigation drawer and then displays the settings screen.
  Future<void> triggerSettingsScreen(ScaffoldState scaffoldState) async {
    int settingsScreenIndex = _selectSettingsIndex();
    bool isCurrentlyAtSetting = state == settingsScreenIndex;
    if (isCurrentlyAtSetting) {
      return;
    } else {
      scaffoldState.openDrawer();
      await Future<void>.delayed(const Duration(milliseconds: 300));
      emit(settingsScreenIndex);
      await Future<void>.delayed(const Duration(milliseconds: 300));
      scaffoldState.closeDrawer();
    }
  }

  /// This function returns the index of the settings screen.
  int _selectSettingsIndex() {
    return panels.indexWhere((element) => element.title == L10n.settings);
  }
}
