import 'package:myapp/featurs/auth/domain/entities/app_user.dart';

class ProfileUser extends AppUser {
  final String bio;
  final String profileImageUrl;
  ProfileUser({
    required super.name,
    required super.email,
    required super.uuid,
    required this.bio,
    required this.profileImageUrl,
  });

  ProfileUser copyWith({
    String? newBio,
    String? newProfileImageUrl,
  }) {
    return ProfileUser(
      uuid: uuid,
      name: name,
      email: email,
      bio: newBio ?? bio,
      profileImageUrl: newProfileImageUrl ?? profileImageUrl,
    );
  }

  //toJson
  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "uuid": uuid,
        "bio": bio,
        "profileImageUrl": profileImageUrl,
      };
  //fromJson
  factory ProfileUser.fromJson(Map<String, dynamic> json) => ProfileUser(
        name: json["name"],
        email: json["email"],
        uuid: json["uuid"],
        bio: json["bio"],
        profileImageUrl: json["profileImageUrl"],
      );
}
