class AppUser {
  String uuid;
  String name;
  String email;

  AppUser({required this.name, required this.email, required this.uuid});

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'name': name,
      'email': email,
    };
  }

  AppUser.fromMap(Map<String, dynamic> map)
      : uuid = map['uuid'],
        name = map['name'],
        email = map['email'];

  @override
  String toString() {
    return 'AppUser(uuid: $uuid, name: $name, email: $email)';
  }
}
