import 'package:gsm_client/auth/profile_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User {
  final String email;
  final String authToken;

  const User({
    required this.email,
    required this.authToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json["email"],
      authToken: json["auth_token"],
    );
  }
}

class RegisterParams {
  final String firstName;
  final String lastName;
  final int birthDate;
  final String email;
  final String password;

  const RegisterParams({
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.password,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "birth_date": birthDate,
      "email": email,
      "password": password,
    };
  }
}

class RegisterResponse {
  final User user;
  final Profile profile;
  final int statusCode;

  const RegisterResponse({
    required this.user,
    required this.profile,
    required this.statusCode,
  });
}

class LoginParams {
  final String email;
  final String password;

  const LoginParams({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
    };
  }
}

class LoginResponse {
  final User? user;
  final int statusCode;

  const LoginResponse({
    this.user,
    required this.statusCode,
  });
}

class UserService {
  Future<RegisterResponse?> register(RegisterParams params) async {
    final response = await http.post(
      Uri.parse("http://127.0.0.1:8080/api/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(params.toJson()),
    );

    if (response.statusCode == 200) {
      final jsonResponseBody = jsonDecode(response.body);
      final user = User.fromJson(jsonResponseBody);
      final profile = Profile.fromJson(jsonResponseBody);

      return RegisterResponse(
        user: user,
        profile: profile,
        statusCode: response.statusCode,
      );
    } else {
      print(
          'POST request failed with status: ${response.statusCode}, reason: ${response.reasonPhrase}!');

      return null;
    }
  }

  Future<LoginResponse> login(LoginParams params) async {
    final response = await http.post(
      Uri.parse("http://127.0.0.1:8080/api/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(params.toJson()),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final user = User.fromJson(responseBody);

      print(user.authToken);

      return LoginResponse(
        user: user,
        statusCode: response.statusCode,
      );
    } else {
      print(
          'POST request failed with status: ${response.statusCode}, reason: ${response.reasonPhrase}!');

      return LoginResponse(statusCode: response.statusCode);
    }
  }
}
