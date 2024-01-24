import 'package:flutter/material.dart';
import 'package:gsm_client/auth/profile_service.dart';
import 'package:gsm_client/auth/user_service.dart';
import 'package:gsm_client/components/button.dart';
import 'package:gsm_client/components/text_field.dart';
import 'package:gsm_client/pages/profile.dart';

class RegisterPage extends StatefulWidget {
  final Function()? goToLoginPage;

  const RegisterPage({
    super.key,
    required this.goToLoginPage,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  DateTime? birthDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: birthDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now().subtract(const Duration(days: 365 * 13)),
    );

    if (pickedDate != null && pickedDate != birthDate) {
      setState(() {
        birthDate = pickedDate;
      });
    }
  }

  signUpHandler() async {
    var registerParams = RegisterParams(
      firstName: firstNameTextController.text,
      lastName: lastNameTextController.text,
      birthDate: birthDate != null
          ? birthDate!.toUtc().millisecondsSinceEpoch ~/ 1000
          : 0,
      password: passwordTextController.text,
      email: emailTextController.text,
    );

    RegisterResponse? registerResponse;
    UserService userService = UserService();
    await userService.register(registerParams).then((value) => {
          if (value != null) {registerResponse = value}
        });

    if (registerResponse?.statusCode == 200) {
      print(registerResponse?.user.authToken);
      openPage(registerResponse!.profile, registerResponse!.user);
    } else {
      print("Error registering your account, please try again.");
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

                const SizedBox(height: 25),

                // welcome back message
                Text(
                  "Welcome, let's register your account!",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                  ),
                ),

                const SizedBox(height: 20),

                // firstName textfiield
                CustomTextField(
                  controller: firstNameTextController,
                  hintText: "First Name",
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // last textfiield
                CustomTextField(
                  controller: lastNameTextController,
                  hintText: "Last Name",
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // Birthdate inputField
                TextFormField(
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  decoration: InputDecoration(
                    // labelText: 'Birthdate',
                    // labelStyle: TextStyle(color: Colors.grey[500]),
                    hintText: birthDate != null
                        ? '${birthDate?.toLocal()}'.split(' ')[0]
                        : 'Select Birthdate',
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintStyle: birthDate == null
                        ? TextStyle(color: Colors.grey[500])
                        : TextStyle(color: Colors.grey[900]),
                  ),
                ),

                const SizedBox(height: 10),

                // email textfiield
                CustomTextField(
                  controller: emailTextController,
                  hintText: "Email",
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                //password textfield
                CustomTextField(
                  controller: passwordTextController,
                  hintText: "Password",
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                //password textfield
                CustomTextField(
                  controller: confirmPasswordTextController,
                  hintText: "Confirm Password",
                  obscureText: true,
                ),

                const SizedBox(height: 20),

                // sign up button
                CustomButton(text: "Sign Up", onTap: signUpHandler),

                const SizedBox(height: 10),

                // go to register page
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: widget.goToLoginPage,
                      child: Text(
                        "Click to sign in",
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
