import 'package:flutter_bloc/flutter_bloc.dart';

import '../config/general.dart';
import '../data/repositories/categories/categories.dart';
import '../data/repositories/event_match/event_matches.dart';
import '../data/repositories/menu/menu.dart';
import '../data/repositories/settings/settings.dart';
import 'bottom_navigation/bottom_navigation_cubit.dart';
import 'channels_categories_cubit/channels_categories_cubit.dart';
import 'connectivity_cubit/connectivity_cubit.dart';
import 'drawer_cubit/drawer_cubit_cubit.dart';
import 'event_matches/event_matches_cubit.dart';
import 'settings_cubit/settings_cubit.dart';

class BlocProviders {
  static get all => [
        BlocProvider(
          create: (context) =>
              ChannelsCategoriesCubit(ChannelsCategoriesRepository()),
        ),
        BlocProvider(
          create: (context) => DrawerCubit(MenuRepository()),
          lazy: Configs.loadMenuItemsLazily,
        ),
        BlocProvider(
          create: (context) => SettingsCubit(SettingsRepository()),
          lazy: Configs.loadAppSettingsLazily,
        ),
        BlocProvider(
          create: (context) => BottomNavigationCubit(0),
        ),
        BlocProvider(
          create: (context) => EventMatchesCubit(MatchEventsRepository()),
          lazy: Configs.loadEventMatchesLazily,
        ),
        
      ];
}
