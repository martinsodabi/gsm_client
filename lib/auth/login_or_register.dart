import 'package:flutter/material.dart';
import 'package:gsm_client/pages/login.dart';
import 'package:gsm_client/pages/register.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(goToRegisterPage: togglePages);
    } else {
      return RegisterPage(goToLoginPage: togglePages);
    }
  }
}
