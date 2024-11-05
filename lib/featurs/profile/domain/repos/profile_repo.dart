import 'package:myapp/featurs/profile/domain/entities/profile_user.dart';

abstract class ProfileRepo {
  Future<ProfileUser?> fetchUserProfile(String uuid);
  Future<void> updateProfile(ProfileUser updatedProfile);
}
