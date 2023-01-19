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
  /// [usernameController] is used to get the username from the text field.
  late final TextEditingController usernameController;

  /// [passwordController] is used to get the password from the text field.
  late final TextEditingController passwordController;

  /// [authRepository] is the responsible repository used to login and logout from the Panel.
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

  /// This function is called when the value of the username field changes.
  /// It updates the state of the [LoginBloc] with the new username value.
  FutureOr<void> _usernameValueChanged(
    UsernameValueChanged event,
    Emitter<LoginBlocState> emit,
  ) {
    emit(state.copyWith(username: event.username));
  }

  /// This function is called when the value of the password field changes.
  /// It updates the state of the [LoginBloc] with the new password value.
  FutureOr<void> _passwordValueChanged(
    PasswordValueChanged event,
    Emitter<LoginBlocState> emit,
  ) {
    emit(state.copyWith(password: event.password));
  }

  /// This function initializes the username and password TextEditingControllers
  /// with the current state of the [LoginBloc].
  void _initControllers() {
    usernameController = TextEditingController(text: state.username);
    passwordController = TextEditingController(text: state.password);
  }

  /// This function is called when the login button is pressed. It handles the
  /// login process by calling the [authRepository.login] function and updating
  /// the state of the [LoginBloc] accordingly.
  FutureOr<void> _loginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginBlocState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      final isLoggedIn = await authRepository.login(
        username: state.username,
        password: state.password,
      );
      event.onSuccess.call();

      emit(state.copyWith(isLoading: false, isLoggedId: isLoggedIn));
    } catch (e) {
      event.onError.call(e.toString());
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  /// This function is called when the logout button is pressed. It updates
  /// the state of the [LoginBloc] to indicate that the user is logged out
  /// and resets the username and password fields to their initial values.
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
