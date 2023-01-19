import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:web_panel/buisness_logic/login_bloc/login_bloc_bloc.dart';
import 'package:web_panel/core/extension/context.dart';
import 'package:web_panel/data/providers/l10n/en.dart';
import 'package:web_panel/presentation/screens/general/margined_body.dart';

import '../general/action_button.dart';
import 'widgets/card_title.dart';
import 'widgets/login_field.dart';

class Login extends StatelessWidget {
  final double cardSize;

  const Login({
    super.key,
    this.cardSize = 400,
  });

  @override
  Widget build(BuildContext context) {
    LoginBloc loginBloc = context.read<LoginBloc>();
    ThemeData theme = Theme.of(context);

    BoxDecoration loginCardDecoration(BuildContext context) {
      return BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: Center(
        child: AspectRatio(
          aspectRatio: 1,
          child: Center(
            child: Container(
              decoration: loginCardDecoration(context),
              width: cardSize,
              height: cardSize,
              child: MarginedBody(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // const Spacer(),
                    // const Logo(),
                    const SizedBox(height: 24),
                    CardTitle(
                      text: L10n.welcome,
                      style: theme.textTheme.headline5?.copyWith(
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
                    const SizedBox(height: 15),
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
                      builder: (BuildContext context, LoginBlocState state) {
                        return ActionButton(
                          width: double.infinity,
                          height: 40,
                          isLoading: state.isLoading,
                          onPressed: () {
                            loginBloc.add(
                              LoginButtonPressed(
                                onSuccess: () {
                                  context.snackBarText(L10n.loginSuccess);
                                },
                                onError: (error) {
                                  context.snackBarText(L10n.loginError);
                                },
                              ),
                            );
                          },
                          text: L10n.login,
                        );
                      },
                    ),
                    const SizedBox(height: 24),
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
