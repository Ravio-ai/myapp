import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
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
  //image picker
  PlatformFile? imagePickedFile;

//web image picker
  Uint8List? webImagePickedFile;

  final editProfileController = TextEditingController();

//picked images

  Future<void> pickedImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: kIsWeb,
    );
    if (result != null) {
      setState(() {
        imagePickedFile = result.files.first;
        if (kIsWeb) {
          webImagePickedFile = result.files.first.bytes;
        }
      });
    }
  }

//update profile button pressed
  void updateProfile() async {
    late final profileCubit = context.read<ProfileCubit>();

    //prepare images
    final String uid = widget.user.uuid;
    final imageMobilePath = kIsWeb ? null : imagePickedFile?.path;
    final imageWebPath = kIsWeb ? imagePickedFile?.bytes : null;
    final String? newBio =
        editProfileController.text.isEmpty ? editProfileController.text : null;

    //update profile

    if (imagePickedFile != null || newBio != null) {
      await profileCubit.updateProfile(
        uuid: uid,
        newBio: editProfileController.text,
        imageMobilePath: imageMobilePath,
        imageWebByte: imageWebPath,
      );
    } else {
      Navigator.pop(context);
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

  Widget buildEditPage() {
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
          //profile images
          Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                shape: BoxShape.circle,
              ),
              clipBehavior: Clip.hardEdge,
              child:
                  //display selected image for mobile
                  (!kIsWeb && imagePickedFile != null)
                      ? Image.file(
                          File(imagePickedFile!.path!),
                          fit: BoxFit.cover,
                        )
                      : //display selected image for web
                      (kIsWeb && webImagePickedFile != null)
                          ? Image.memory(
                              webImagePickedFile!,
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              imageUrl: widget.user.profileImageUrl,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (
                                context,
                                url,
                                error,
                              ) =>
                                  Icon(
                                Icons.person,
                                size: 72,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              imageBuilder: (
                                context,
                                imageProvider,
                              ) =>
                                  Image(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
            ),
          ),

          const SizedBox(
            height: 25,
          ),

          Center(
            child: MaterialButton(
              onPressed: pickedImage,
              color: Colors.blue,
              child: const Text("Upload Image"),
            ),
          ),

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
