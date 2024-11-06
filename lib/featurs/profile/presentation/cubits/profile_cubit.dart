import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/featurs/profile/domain/repos/profile_repo.dart';
import 'package:myapp/featurs/profile/presentation/cubits/profile_state.dart';
import 'package:myapp/featurs/storage/domain/storage_repo.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;
  final StorageRepo storageRepo;
  ProfileCubit({required this.profileRepo, required this.storageRepo})
      : super(ProfileInitial());

  //get profile user in try catch
  Future<void> getUserProfile(String uuid) async {
    try {
      emit(ProfileLoading());
      final profileUser = await profileRepo.fetchUserProfile(uuid);
      if (profileUser != null) {
        emit(ProfileLoaded(user: profileUser));
      } else {
        emit(ProfileError(message: 'profile user not found'));
      }
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  //update bio and profile image url
  Future<void> updateProfile({
    required String uuid,
    String? newBio,
    Uint8List? imageWebByte,
    String? imageMobilePath,
  }) async {
    emit(ProfileLoading());
    try {
      final currentUser = await profileRepo.fetchUserProfile(uuid);
      //update profile image
      String? imageDownloadUrl;
      if (imageWebByte != null || imageMobilePath != null) {
        if (imageMobilePath != null) {
          imageDownloadUrl =
              await storageRepo.uploadProfileImageMobile(imageMobilePath, uuid);
        } else if (imageWebByte != null) {
          imageDownloadUrl =
              await storageRepo.uploadProfileImageWeb(imageWebByte, uuid);
        }
      }
      if (imageDownloadUrl == null) {
        emit(ProfileError(message: 'failed to upload image'));
      }
      final updatedProfile = currentUser?.copyWith(
        newBio: newBio,
        newProfileImageUrl: imageDownloadUrl,
      );

      //update in repo
      await profileRepo.updateProfile(updatedProfile!);

      await getUserProfile(uuid);
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }
}
