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

    on<UsernameValueChanged>(_usernameValueChanged);
    on<PasswordValueChanged>(_passwordValueChanged);
    on<LoginButtonPressed>(_loginButtonPressed);
    on<LogoutButtonPressed>(_logoutButtonPressed);
  }

  FutureOr<void> _usernameValueChanged(
    UsernameValueChanged event,
    Emitter<LoginBlocState> emit,
  ) {
    emit(state.copyWith(username: event.username));
  }

  FutureOr<void> _passwordValueChanged(
    PasswordValueChanged event,
    Emitter<LoginBlocState> emit,
  ) {
    emit(state.copyWith(password: event.password));
  }

  void _initControllers() {
    usernameController = TextEditingController(text: state.username);
    passwordController = TextEditingController(text: state.password);
  }

  FutureOr<void> _loginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginBlocState> emit,
  ) async {
    try {
      emit(state.copyWith(
        isLoading: true,
      ));

      final isLoggedIn = await authRepository.login(
        username: state.username,
        password: state.password,
      );
      event.onSuccess.call();

      emit(state.copyWith(
        isLoading: false,
        isLoggedId: isLoggedIn,
      ));
    } catch (e) {
      event.onError.call(e.toString());
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  FutureOr<void> _logoutButtonPressed(
    LogoutButtonPressed event,
    Emitter<LoginBlocState> emit,
  ) {
    emit(state.copyWith(
      isLoggedId: false,
      username: initialUsername,
      password: initialPassword,
    ));
    event.onSuccess.call();
  }
}
