import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yacine_tv/core/lang/en.dart';

import 'core/core.dart';
import 'logic/bloc_providers.dart';
import 'presentation/config/theme.dart';
import 'presentation/screens/bottom_navigation_screens_handler/bottom_navigation_screens_handler.dart';

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
      providers: BlocProviders.all,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: L10n.title,
        theme: Themes.light,
        themeMode: ThemeMode.light,
        home: const ScreensHandler(),
      ),
    );
  }
}
