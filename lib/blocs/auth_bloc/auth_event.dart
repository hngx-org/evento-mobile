part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginUserEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginUserEvent(this.email, this.password);
}

class RegisterUserEvent extends AuthEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;

  const RegisterUserEvent(
      this.email, this.password, this.firstName, this.lastName);
}

class ForgotPasswordEvent extends AuthEvent {
  final String email;

  const ForgotPasswordEvent(
    this.email,
  );
}
