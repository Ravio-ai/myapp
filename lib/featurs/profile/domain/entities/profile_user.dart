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
    String? name,
    String? email,
    String? uuid,
    String? bio,
    String? profileImageUrl,
  }) {
    return ProfileUser(
      name: name ?? this.name,
      email: email ?? this.email,
      uuid: uuid ?? this.uuid,
      bio: bio ?? this.bio,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
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
