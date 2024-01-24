import 'package:flutter/material.dart';
import 'package:gsm_client/auth/profile_service.dart';
import 'package:gsm_client/auth/user_service.dart';
import 'package:gsm_client/components/button.dart';
import 'package:gsm_client/components/text_field.dart';
import 'package:gsm_client/pages/profile.dart';

class LoginPage extends StatefulWidget {
  final Function()? goToRegisterPage;

  const LoginPage({
    super.key,
    required this.goToRegisterPage,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  signInHandler() async {
    LoginParams loginParams = LoginParams(
      email: emailTextController.text,
      password: passwordTextController.text,
    );

    UserService userService = UserService();
    LoginResponse loginResponse = await userService.login(loginParams);

    if (loginResponse.statusCode == 200) {
      ProfileParams profileParams =
          ProfileParams(authToken: loginResponse.user!.authToken);

      ProfileService profileService = ProfileService();

      ProfileResponse profileResponse =
          await profileService.getMyProfile(profileParams);

      if (profileResponse.statusCode == 200) {
        openPage(profileResponse.profile!, loginResponse.user!);
      }
    }
  }

  openPage(Profile profile, User user) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProfilePage(profile: profile, user: user)));
  }

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
                CustomButton(text: "Sign In", onTap: signInHandler),

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
                      onTap: widget.goToRegisterPage,
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
