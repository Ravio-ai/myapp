import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/featurs/profile/domain/repos/profile_repo.dart';
import 'package:myapp/featurs/profile/presentation/cubits/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;
  ProfileCubit({required this.profileRepo}) : super(ProfileInitial());

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
  Future<void> updateProfile({required String uuid, String? newBio}) async {
    emit(ProfileLoading());
    try {
      final currentUser = await profileRepo.fetchUserProfile(uuid);
      final updatedProfile = currentUser?.copyWith(newBio: newBio);
      //update in repo
      await profileRepo.updateProfile(updatedProfile!);

      await getUserProfile(uuid);
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }
}
