part of 'login_bloc_bloc.dart';

@immutable
abstract class LoginBlocEvent extends Equatable {
  const LoginBlocEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginBlocEvent {
  final VoidCallback onSuccess;
  final void Function(String) onError;
  const LoginButtonPressed({
    required this.onError,
    required this.onSuccess,
  });
}

class UsernameValueChanged extends LoginBlocEvent {
  final String username;
  const UsernameValueChanged({required this.username});

  @override
  List<Object> get props => [username];
}

class PasswordValueChanged extends LoginBlocEvent {
  final String password;
  const PasswordValueChanged({required this.password});

  @override
  List<Object> get props => [password];
}
