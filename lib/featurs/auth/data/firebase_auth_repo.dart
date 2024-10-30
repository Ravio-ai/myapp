import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/featurs/auth/domain/entities/app_user.dart';
import 'package:myapp/featurs/auth/domain/repos/auth_repo.dart';

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<AppUser?> getCurrentUser() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      AppUser appUser = AppUser(name: '', email: user.email!, uuid: user.uid);
      return Future.value(appUser);
    }
    return null;
  }

  @override
  Future<AppUser?> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      AppUser user =
          AppUser(name: '', email: email, uuid: userCredential.user!.uid);
      return user;
    } catch (e) {
      throw Exception('Error logging in: $e');
    }
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
  }

  @override
  Future<AppUser?> registerWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      AppUser user =
          AppUser(name: name, email: email, uuid: userCredential.user!.uid);
      return user;
    } catch (e) {
      throw Exception('Error logging in: $e');
    }
  }
}
