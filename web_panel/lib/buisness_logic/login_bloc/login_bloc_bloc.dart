import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_panel/data/repositories/auth_repository/auth_repository.dart';

part 'login_bloc_event.dart';
part 'login_bloc_state.dart';

const String initialUsername = 'admin';
const String initialPassword = 'admin';

class LoginBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  final usernameController = TextEditingController(text: initialUsername);
  final passwordController = TextEditingController(text: initialPassword);
  AuthRepository authRepository;

  LoginBloc(this.authRepository)
      : super(const LoginBlocState(
          username: initialUsername,
          password: initialPassword,
        )) {
    on<UsernameValueChanged>((event, emit) {
      emit(state.copyWith(username: event.username));
    });

    on<PasswordValueChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<LoginButtonPressed>((event, emit) async {
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
    });
  }
}
