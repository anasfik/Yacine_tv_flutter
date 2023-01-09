// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc_bloc.dart';

@immutable
class LoginBlocState extends Equatable {
  final bool isLoading;
  final String? loginError;
  final bool canAccess;
  const LoginBlocState({
    this.isLoading = false,
    this.loginError,
    this.canAccess = false,
  });

  @override
  List<Object?> get props => [isLoading, loginError, canAccess];

  LoginBlocState copyWith({
    bool? isLoading,
    String? loginError,
    bool? canAccess,
  }) {
    return LoginBlocState(
      isLoading: isLoading ?? this.isLoading,
      loginError: loginError ?? this.loginError,
      canAccess: canAccess ?? this.canAccess,
    );
  }
}
