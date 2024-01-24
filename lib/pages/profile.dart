import 'package:flutter/material.dart';
import 'package:gsm_client/auth/profile_service.dart';
import 'package:gsm_client/auth/user_service.dart';

class ProfilePage extends StatefulWidget {
  final Profile profile;
  final User user;

  const ProfilePage({
    super.key,
    required this.profile,
    required this.user,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Profile Page",
              style: TextStyle(
                fontSize: 32,
                color: Colors.grey[900],
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.profile.firstName,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  widget.profile.lastName,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 25),
              ],
            ),
            const SizedBox(height: 25),
            Text(
              widget.profile.birthdate.toLocal().toString().split(" ")[0],
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 25),
            Text(
              widget.profile.location,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 25),
            Text(
              widget.profile.isVisible
                  ? "Your account is visible"
                  : "Your account is not visible",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 25),
            Text(
              widget.user.email,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 25)
          ],
        ),
      )),
    );
  }
}
