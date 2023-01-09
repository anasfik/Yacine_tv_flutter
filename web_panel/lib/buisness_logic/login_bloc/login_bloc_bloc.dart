import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'login_bloc_event.dart';
part 'login_bloc_state.dart';

class LoginBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  late final TextEditingController usernameController;
  late final TextEditingController passwordController;

  LoginBloc() : super(LoginBlocInitial()) {
    usernameController = TextEditingController(text: "admin");
    passwordController = TextEditingController(text: "admin");

    on<LoginBlocEvent>((event, emit) {});
  }

  @override
  close() {
    usernameController.dispose();
    return super.close();
  }
}
