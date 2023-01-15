import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yacine_tv/core/lang/en.dart';
import 'config/general.dart';
import 'data/repositories/categories/categories.dart';
import 'data/repositories/menu/menu.dart';
import 'data/repositories/settings/settings.dart';
import 'logic/channels_categories_cubit/channels_categories_cubit.dart';
import 'core/core.dart';
import 'logic/drawer_cubit/drawer_cubit_cubit.dart';
import 'logic/settings_cubit/settings_cubit.dart';
import 'presentation/config/theme.dart';
import 'presentation/screens/home/home.dart';

Future<void> main() async {
  await Core.init();
  await Themes.decodeThemes();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: L10n.title,
        theme: Themes.light,
        themeMode: ThemeMode.light,
        home: const Home(),
      ),
    );
  }
}
