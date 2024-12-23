import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/constants/validators.dart'; // Ensure validators are imported
import 'package:todo_task/controller/Authentication/bloc/authentication_bloc.dart';
import 'package:todo_task/view/forgotpassword/ForgotPassword.dart';
import 'package:todo_task/view/home/home.dart';
import 'package:todo_task/view/registerScreen/registerScree.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is LoggedInSuccessState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        } else if (state is NavigationDoneRegisterScreenState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const RegisterScreen()),
          );
        } else if (state is NavigationDoneForgotPasswrodScreenState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Forgotpassword()),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const Spacer(flex: 2),
                    // Email Field
                    TextFormField(
                      controller: _emailController,
                      validator: emailValidate, // Email validator
                      decoration: const InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Password Field
                    TextFormField(
                      controller: _passController,
                      validator: passwordValidate, // Password validator
                      decoration: const InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Forgotpassword()),
                          );
                        },
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Login Button
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthenticationBloc>(context).add(
                            LoginButtonClickedEvent(
                              email: _emailController.text,
                              password: _passController.text,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 11, 86, 147),
                        minimumSize: const Size(double.infinity, 60),
                        shape: const RoundedRectangleBorder(),
                      ),
                      child: const Text(
                        "CONTINUE",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<AuthenticationBloc>(context)
                            .add(NavigateToRegisterScreenEvent());
                      },
                      child: const Center(
                        child: Text.rich(
                          TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: "Register",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Spacer(flex: 1),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
