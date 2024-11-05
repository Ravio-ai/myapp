import 'package:myapp/featurs/profile/domain/entities/profile_user.dart';

abstract class ProfileRepo {
  Future<ProfileUser?> getProfileUser(String uuid);
  Future<void> updateProfileUser(ProfileUser user);
}
