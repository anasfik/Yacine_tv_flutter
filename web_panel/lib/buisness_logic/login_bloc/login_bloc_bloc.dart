import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_panel/data/repositories/auth_repository/auth_repository.dart';

part 'login_bloc_event.dart';
part 'login_bloc_state.dart';

const String initialUsername = 'admin';
const String initialPassword = 'admin';

class LoginBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  late final TextEditingController usernameController;
  late final TextEditingController passwordController;
  AuthRepository authRepository;

  LoginBloc(this.authRepository)
      : super(const LoginBlocState(
          username: initialUsername,
          password: initialPassword,
        )) {
    _initControllers();

    on<UsernameValueChanged>(_onUsernameChanged);
    on<PasswordValueChanged>(_onPasswordChanged);
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  FutureOr<void> _onUsernameChanged(
    UsernameValueChanged event,
    Emitter<LoginBlocState> emit,
  ) {
    (event, emit) {
      emit(state.copyWith(username: event.username));
    };
  }

  FutureOr<void> _onPasswordChanged(
    PasswordValueChanged event,
    Emitter<LoginBlocState> emit,
  ) {
    (event, emit) {
      emit(state.copyWith(password: event.password));
    };
  }

  FutureOr<void> _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<LoginBlocState> emit) {
    (event, emit) async {
      try {
        emit(state.copyWith(
          isLoading: true,
        ));

        final bool shouldAccess = await authRepository.login(
          username: state.username,
          password: state.password,
        );
        event.onSuccess.call();
      } catch (e) {
        event.onError.call(e.toString());
      } finally {
        emit(state.copyWith(
          isLoading: false,
        ));
      }
    };
  }

  void _initControllers() {
    usernameController = TextEditingController(text: initialUsername);
    passwordController = TextEditingController(text: initialPassword);
  }
}
