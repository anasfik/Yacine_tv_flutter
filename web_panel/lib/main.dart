import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web_panel/buisness_logic/login_bloc/login_bloc_bloc.dart';
import 'package:web_panel/data/providers/l10n/en.dart';

import 'buisness_logic/bloc_providers/bloc_providers.dart';
import 'data/repositories/channels_categories_repository/channels_categories_repository.dart';
import 'presentation/config/themes/themes.dart';
import 'presentation/screens/dashboard/dashboard.dart';
import 'presentation/screens/login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: BlocProviders.all(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: L10n.appName,
        theme: AppThemes.light,
        home: BlocBuilder<LoginBloc, LoginBlocState>(
          builder: (context, state) {
            if (state.isLoggedId) {
              return const DashBoard();
            } else {
              return const Login();
            }
          },
        ),
      ),
    );
  }
}
