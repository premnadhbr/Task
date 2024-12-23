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