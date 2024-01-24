import 'package:http/http.dart' as http;
import 'dart:convert';

class Profile {
  final String firstName;
  final String lastName;
  final String location;
  final DateTime birthdate;
  final bool isVisible;

  const Profile({
    required this.firstName,
    required this.lastName,
    required this.birthdate,
    required this.location,
    required this.isVisible,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      firstName: json["first_name"],
      lastName: json["last_name"],
      birthdate: DateTime.fromMillisecondsSinceEpoch(json["birth_date"] * 1000),
      location: json["location"] ?? "JOS",
      isVisible: json["is_visible"],
    );
  }
}

class ProfileParams {
  final String authToken;

  const ProfileParams({
    required this.authToken,
  });

  Map<String, dynamic> toJson() {
    return {"auth_token": authToken};
  }
}

class ProfileResponse {
  final Profile? profile;
  final int statusCode;

  const ProfileResponse({
    this.profile,
    required this.statusCode,
  });
}

class ProfileService {
  Future<ProfileResponse> getMyProfile(ProfileParams params) async {
    final response = await http.get(
      Uri.parse("http://127.0.0.1:8080/api/get_profile"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${params.authToken}",
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final profile = Profile.fromJson(jsonResponse);
      return ProfileResponse(profile: profile, statusCode: response.statusCode);
    } else {
      return ProfileResponse(statusCode: response.statusCode);
    }
  }
}
