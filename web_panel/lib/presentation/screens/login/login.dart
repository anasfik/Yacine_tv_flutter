import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:web_panel/buisness_logic/login_bloc/login_bloc_bloc.dart';
import 'package:web_panel/data/l10n/en.dart';
import 'package:web_panel/presentation/screens/general/margined_body.dart';

import '../general/action_button.dart';
import 'widgets/card_title.dart';
import 'widgets/login_field.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: 1,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 5,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              width: 400,
              child: MarginedBody(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(
                      height: 15,
                    ),
                    CardTitle(
                      text: L10n.welcome,
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    LoginField(
                      icon: FlutterRemix.user_2_fill,
                      label: L10n.username,
                      controller: context.read<LoginBloc>().usernameController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    LoginField(
                      icon: FlutterRemix.lock_password_fill,
                      label: L10n.password,
                      controller: context.read<LoginBloc>().passwordController,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    BlocConsumer<LoginBloc, LoginBlocState>(
                      listener: (context, state) {
                        if (state.isLoading) {
                          if (state.loginError != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.loginError!),
                              ),
                            );
                          } else if (state.canAccess) {
                            Navigator.of(context)
                                .pushReplacementNamed("/dashboard");
                          }
                        }
                      },
                      builder: (context, state) {
                        return ActionButton(
                          isLoading: state.isLoading,
                          onPressed: () {
                            print("aa");
                            context.read<LoginBloc>().add(LoginButtonPressed());
                          },
                          text: L10n.login,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
