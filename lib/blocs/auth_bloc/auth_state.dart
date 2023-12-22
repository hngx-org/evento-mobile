part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {
  final String userId;
  final String token;
  final String message;
  const LoginSuccess(this.userId, this.token, this.message);
}

final class LoginFailed extends AuthState {
  final String error;

  const LoginFailed({required this.error});

  @override
  String toString() => 'LoginFailed { error: $error }';
}

final class RegisterLoading extends AuthState {}

final class RegisterSuccess extends AuthState {
  final String message;
  const RegisterSuccess(this.message);
}

final class RegisterFailed extends AuthState {
  final String error;

  const RegisterFailed({required this.error});

  @override
  String toString() => 'RegisterFailed { error: $error }';
}
