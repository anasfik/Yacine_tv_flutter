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
                        controller:
                            context.read<LoginBloc>().usernameController,
                        onChanged: (value) {
                          context
                              .read<LoginBloc>()
                              .add(UsernameValueChanged(username: value));
                        },
                        icon: FlutterRemix.user_2_fill,
                        label: L10n.username,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      LoginField(
                        controller:
                            context.read<LoginBloc>().passwordController,
                        icon: FlutterRemix.lock_password_fill,
                        label: L10n.password,
                        onChanged: (value) {
                          context
                              .read<LoginBloc>()
                              .add(PasswordValueChanged(password: value));
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      BlocBuilder<LoginBloc, LoginBlocState>(
                        builder: (context, state) => ActionButton(
                          isLoading: state.isLoading,
                          onPressed: () {
                            context.read<LoginBloc>().add(
                                  LoginButtonPressed(
                                    onSuccess: () {
                                      Navigator.of(context).pushNamed(
                                        '/dashboard',
                                      );
                                    },
                                    onError: (error) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(error),
                                        ),
                                      );
                                    },
                                  ),
                                );
                          },
                          text: L10n.login,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
