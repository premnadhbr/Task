part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {}

class LoginButtonClickedEvent extends AuthenticationEvent {
  final String email;
  final String password;
  LoginButtonClickedEvent({
    required this.email,
    required this.password,
  });
}

class NavigateToRegisterScreenEvent extends AuthenticationEvent {}

class NavigateToForgotPasswordScreen extends AuthenticationEvent {}

class BackButtonPressedEvent extends AuthenticationEvent {}

class RegisterButtonClickedEvent extends AuthenticationEvent {
  final String name;
  final String email;
  final String password;
  RegisterButtonClickedEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}
