import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/featurs/profile/domain/entities/profile_user.dart';
import 'package:myapp/featurs/profile/domain/repos/profile_repo.dart';

class FirebaseProfileRepo implements ProfileRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Future<ProfileUser?> fetchUserProfile(String uuid) async {
    try {
      final userDoc = await _firestore.collection('users').doc(uuid).get();
      if (userDoc.exists) {
        final userData = userDoc.data();
        if (userData != null) {
          return ProfileUser(
            uuid: uuid,
            name: userData['name'],
            email: userData['email'],
            bio: userData['bio'] ?? "",
            profileImageUrl: userData['profileImageUrl'].toString(),
          );
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> updateProfile(ProfileUser user) async {
    try {
      await _firestore.collection('users').doc(user.uuid).update({
        'bio': user.bio,
        'profileImageUrl': user.profileImageUrl,
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
