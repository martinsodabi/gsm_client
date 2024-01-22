import 'package:flutter/material.dart';
import 'package:gsm_client/components/button.dart';
import 'package:gsm_client/components/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                const Icon(
                  Icons.lock,
                  size: 100,
                ),

                const SizedBox(height: 50),

                // welcome back message
                Text(
                  "Welcome back, we missed you!",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                  ),
                ),

                const SizedBox(height: 25),

                // email textfiield
                CustomTextField(
                  controller: emailTextController,
                  hintText: "Email",
                  obscureText: false,
                ),

                const SizedBox(height: 15),

                //password textfield
                CustomTextField(
                  controller: passwordTextController,
                  hintText: "Password",
                  obscureText: true,
                ),

                const SizedBox(height: 15),

                // sign in button
                CustomButton(text: "Sign In", onTap: () {}),

                const SizedBox(height: 15),

                // go to register page
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Click to register now",
                        style: TextStyle(
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
