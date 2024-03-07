import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yacine_tv/core/extensions/context.dart';
import 'package:yacine_tv/core/lang/en.dart';
import 'package:yacine_tv/logic/connectivity_cubit/connectivity_cubit.dart';
import 'package:yacine_tv/presentation/config/colors.dart';
import 'package:yacine_tv/presentation/screens/general/loading.dart';
import 'package:yacine_tv/presentation/screens/general/margined_body.dart';

import '../../config/theme.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConnectivityCubit(),
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: L10n.title,
            theme: Themes.light,
            themeMode: ThemeMode.light,
            home: Scaffold(
              body: Center(
                child: MarginedBody(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        L10n.noInternet,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<ConnectivityCubit, ConnectivityState>(
                        builder: (context, state) {
                          return SizedBox(
                            width: 100,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                ),
                              ),
                              onPressed: () {
                                context
                                    .read<ConnectivityCubit>()
                                    .checkConnectivity(
                                  onError: (error) {
                                    context.snackBarText(L10n.error);
                                  },
                                );
                              },
                              child: state.isChecking
                                  ? SizedBox(
                                      width: textPaintWidth(
                                        L10n.retry,
                                        Theme.of(context)
                                            .textTheme
                                            .titleMedium!,
                                      ).height,
                                      height: textPaintWidth(
                                        L10n.retry,
                                        Theme.of(context)
                                            .textTheme
                                            .titleMedium!,
                                      ).height,
                                      child: Center(
                                        child: LoadingWidget(
                                          strokeWidth: 2.0,
                                          color: MainColors.white,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      L10n.retry,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                          ),
                                    ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Size textPaintWidth(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();

    return textPainter.size;
  }
}
