import 'dart:typed_data';

import 'package:myapp/featurs/storage/domain/storage_repo.dart';

class FirebaseStorageRepo implements StorageRepo {
  @override
  Future<String?> uploadProfileImageMobile(String path, String fileName) {
    // TODO: implement uploadProfileImageMobile
    throw UnimplementedError();
  }

  @override
  Future<String?> uploadProfileImageWeb(Uint8List fileBype, String fileName) {
    // TODO: implement uploadProfileImageWeb
    throw UnimplementedError();
  }
}
