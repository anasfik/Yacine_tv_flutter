import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_panel/data/auth_repository/auth_repository.dart';

part 'login_bloc_event.dart';
part 'login_bloc_state.dart';

class LoginBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  late final TextEditingController usernameController;
  late final TextEditingController passwordController;

  AuthRepository authRepository;

  LoginBloc(this.authRepository) : super(const LoginBlocState()) {
    usernameController = TextEditingController(text: "admin");
    passwordController = TextEditingController(text: "admin");

    on<LoginButtonPressed>((event, emit) async {
      try {
        emit(state.copyWith(isLoading: true));
        final bool shouldAccess = await authRepository.login(
          username: usernameController.text,
          password: passwordController.text,
        );
        emit(state.copyWith(canAccess: shouldAccess));
      } catch (e) {
        emit(
          state.copyWith(
            loginError: e.toString(),
          ),
        );
      } finally {
        emit(state.copyWith(isLoading: false));
      }
    });
  }

  @override
  close() {
    usernameController.dispose();
    return super.close();
  }
}
