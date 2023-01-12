import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:web_panel/buisness_logic/login_bloc/login_bloc_bloc.dart';
import 'package:web_panel/data/providers/l10n/en.dart';
import 'package:web_panel/presentation/screens/dashboard/dashboard.dart';
import 'package:web_panel/presentation/screens/general/margined_body.dart';

import '../general/action_button.dart';
import '../general/logo.dart';
import 'widgets/card_title.dart';
import 'widgets/login_field.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: AspectRatio(
          aspectRatio: 1,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
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
              height: 400,
              child: MarginedBody(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Spacer(),
                    const Logo(),
                    const SizedBox(
                      height: 24,
                    ),
                    CardTitle(
                      text: L10n.welcome,
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                    ),
                    const Spacer(),
                    LoginField(
                      controller: loginBloc.usernameController,
                      onChanged: (value) {
                        loginBloc.add(UsernameValueChanged(username: value));
                      },
                      icon: FlutterRemix.user_2_fill,
                      label: L10n.username,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    LoginField(
                      controller: loginBloc.passwordController,
                      icon: FlutterRemix.lock_password_fill,
                      label: L10n.password,
                      onChanged: (value) {
                        loginBloc.add(PasswordValueChanged(password: value));
                      },
                    ),
                    const Spacer(),
                    BlocBuilder<LoginBloc, LoginBlocState>(
                      builder: (context, state) => ActionButton(
                        width: double.infinity,
                        height: 40,
                        isLoading: state.isLoading,
                        onPressed: () {
                          void showSnackBar(String msg) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(msg)),
                            );
                          }

                          loginBloc.add(
                            LoginButtonPressed(
                              onSuccess: () {
                                showSnackBar(L10n.loginSuccess);
                              },
                              onError: (error) {
                                showSnackBar(L10n.loginError);
                              },
                            ),
                          );
                        },
                        text: L10n.login,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
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
