import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:web_panel/data/providers/l10n/en.dart';

import '../../data/models/dashboard_screen.dart';
import '../../presentation/screens/channels_categories/channels_categories.dart';
import '../../presentation/screens/math_events/math_events.dart';

class DashBoardScreensCubit extends Cubit<int> {
  final List<DashBoardScreen> panels = <DashBoardScreen>[
    const DashBoardScreen(
      title: L10n.channelsCategories,
      screen: ChannelsCategories(title: L10n.channelsCategories),
      icon: FlutterRemix.chat_settings_fill,
    ),
    const DashBoardScreen(
      title: L10n.mathEvents,
      screen: MathEvents(),
      icon: FlutterRemix.chat_settings_fill,
    ),
  ];

  DashBoardScreensCubit(int currentIndex) : super(currentIndex);
  void triggerScreenAt(int index) {
    emit(index);
  }
}
