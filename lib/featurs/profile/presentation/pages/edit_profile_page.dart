import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/featurs/auth/presentation/componenets/my_text_field.dart';
import 'package:myapp/featurs/profile/domain/entities/profile_user.dart';
import 'package:myapp/featurs/profile/presentation/cubits/profile_cubit.dart';
import 'package:myapp/featurs/profile/presentation/cubits/profile_state.dart';

class EditProfilePage extends StatefulWidget {
  final ProfileUser user;
  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final editProfileController = TextEditingController();

//update profile button pressed
  void updateProfile() async {
    late final profileCubit = context.read<ProfileCubit>();

    if (editProfileController.text.isNotEmpty) {
      await profileCubit.updateProfile(
        uuid: widget.user.uuid,
        newBio: editProfileController.text,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    editProfileController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 25),
                  Text(
                    "Loading...",
                  ),
                ],
              ),
            ),
          );
        } else {
          return buildEditPage();
        }
      },
      listener: (context, state) {
        if (state is ProfileLoaded) {
          Navigator.pop(context);
        } else if (state is ProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
    );
  }

  Widget buildEditPage({double uploadProgress = 0.0}) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        foregroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            onPressed: updateProfile,
            icon: const Icon(Icons.upload),
          ),
        ],
      ),
      body: Column(
        children: [
          Text(
            "Bio",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 25.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: MyTextField(
              controller: editProfileController,
              hint: widget.user.bio,
              obscureText: false,
            ),
          ),
        ],
      ),
    );
  }
}
