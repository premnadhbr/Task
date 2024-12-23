// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

class LoggedInSuccessState extends AuthenticationState {}

class NavigationDoneRegisterScreenState extends AuthenticationState {}

class NavigationDoneForgotPasswrodScreenState extends AuthenticationState {}

class BackButtonPressedState extends AuthenticationState {}

class RegisteredSuccessState extends AuthenticationState {
  final String uid;
  RegisteredSuccessState({
    required this.uid,
  });
}
