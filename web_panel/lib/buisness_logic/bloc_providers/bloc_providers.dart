import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_panel/buisness_logic/event_channels_bloc/event_channels_bloc_bloc.dart';
import 'package:web_panel/buisness_logic/login_bloc/login_bloc_bloc.dart';
import 'package:web_panel/buisness_logic/menu_bloc/menu_bloc_bloc.dart';
import 'package:web_panel/buisness_logic/settings_bloc/settings_bloc.dart';
import 'package:web_panel/data/repositories/auth_repository/auth_repository.dart';
import 'package:web_panel/data/repositories/match_events/match_events.dart';

import '../../data/repositories/channels_categories_repository/channels_categories_repository.dart';
import '../../data/repositories/menu/menu.dart';
import '../../data/repositories/settings_repository/settings_repository.dart';
import '../channels_categories_bloc/channels_categories_bloc.dart';
import '../dashbord_cubit/dashboard_cubit.dart';

class BlocProviders {
  static List<BlocProvider> all() {
    return <BlocProvider>[
      BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(AuthRepository()),
      ),
      BlocProvider<DashBoardScreensCubit>(
        create: (context) => DashBoardScreensCubit(0),
      ),
      BlocProvider<ChannelsCategoriesBloc>(
        create: (context) => ChannelsCategoriesBloc(
          ChannelsCategoriesRepository(),
        ),
      ),
      BlocProvider<EventChannelsBlocBloc>(
        create: (context) => EventChannelsBlocBloc(
          matchEventsRepository: MatchEventsRepository(),
        ),
      ),
      BlocProvider<MenuBloc>(
        create: (context) => MenuBloc(MenuRepository()),
      ),
      BlocProvider<SettingsBloc>(
        create: (context) => SettingsBloc(SettingsRepository()),
      )
    ];
  }
}
