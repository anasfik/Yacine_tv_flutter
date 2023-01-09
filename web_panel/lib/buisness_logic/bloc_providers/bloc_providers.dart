import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_panel/buisness_logic/login_bloc/login_bloc_bloc.dart';
import 'package:web_panel/data/auth_repository/auth_repository.dart';

class BlocProviders {
  static List<BlocProvider> all() {
    return <BlocProvider>[
      BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(AuthRepository()),
      ),
    ];
  }
}
