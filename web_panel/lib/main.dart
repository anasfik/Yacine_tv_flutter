import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web_panel/data/l10n/en.dart';

import 'buisness_logic/bloc_providers/bloc_providers.dart';
import 'presentation/config/themes/themes.dart';
import 'presentation/screens/login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: BlocProviders.all(),
      child: MaterialApp(
        title: L10n.appName,
        theme: AppThemes.light,
        home: const Login(),
        routes: {
          "/dashboard": (context) => const Scaffold(
                body: Center(
                  child: Text("Dashboard"),
                ),
              )
        },
      ),
    );
  }
}
