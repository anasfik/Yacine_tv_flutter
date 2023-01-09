// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc_bloc.dart';

@immutable
class LoginBlocState extends Equatable {
  final String username;
  final String password;
  final bool isLoading;

  const LoginBlocState({
    this.username = '',
    this.password = '',
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [isLoading, username, password];

  LoginBlocState copyWith({
    String? username,
    String? password,
    bool? isLoading,
  }) {
    return LoginBlocState(
      username: username ?? this.username,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
