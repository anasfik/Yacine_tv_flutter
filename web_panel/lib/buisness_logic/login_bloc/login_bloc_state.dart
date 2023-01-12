// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc_bloc.dart';

@immutable
class LoginBlocState extends Equatable {
  final String username;
  final String password;
  final bool isLoading;
  final bool isLoggedId;

  const LoginBlocState({
    this.username = '',
    this.password = '',
    this.isLoading = false,
    this.isLoggedId = false,
  });

  @override
  List<Object?> get props => [isLoading, username, password, isLoggedId];

  LoginBlocState copyWith({
    String? username,
    String? password,
    bool? isLoading,
    bool? isLoggedId,
  }) {
    return LoginBlocState(
      username: username ?? this.username,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      isLoggedId: isLoggedId ?? this.isLoggedId,
    );
  }
}
