import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? user;
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<LoginButtonClickedEvent>(loginButtonClickedEvent);
    on<NavigateToRegisterScreenEvent>(navigateToRegisterScreenEvent);
    on<NavigateToForgotPasswordScreen>(navigateToForgotPasswordScreen);
    on<BackButtonPressedEvent>(backButtonPressedEvent);
    on<RegisterButtonClickedEvent>(registerButtonClickedEvent);
  }

  FutureOr<void> loginButtonClickedEvent(
      LoginButtonClickedEvent event, Emitter<AuthenticationState> emit) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      emit(LoggedInSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  FutureOr<void> navigateToRegisterScreenEvent(
      NavigateToRegisterScreenEvent event, Emitter<AuthenticationState> emit) {
    emit(NavigationDoneRegisterScreenState());
  }

  FutureOr<void> navigateToForgotPasswordScreen(
      NavigateToForgotPasswordScreen event,
      Emitter<AuthenticationState> emit) {}

  FutureOr<void> backButtonPressedEvent(
      BackButtonPressedEvent event, Emitter<AuthenticationState> emit) {
    emit(BackButtonPressedState());
  }

  FutureOr<void> registerButtonClickedEvent(RegisterButtonClickedEvent event,
      Emitter<AuthenticationState> emit) async {
    try {
      UserCredential result = await firebaseAuth.createUserWithEmailAndPassword(
          email: event.email, password: event.password);

      user = result.user;

      emit(RegisteredSuccessState(uid: user!.uid));
    } catch (e) {}
  }
}
