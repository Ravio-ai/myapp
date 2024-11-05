import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/featurs/auth/domain/entities/app_user.dart';
import 'package:myapp/featurs/auth/presentation/cubits/auth_cubit.dart';
import 'package:myapp/featurs/profile/presentation/componetets/bio_box.dart';
import 'package:myapp/featurs/profile/presentation/cubits/profile_cubit.dart';
import 'package:myapp/featurs/profile/presentation/cubits/profile_state.dart';

class ProfilePage extends StatefulWidget {
  final String uuid;
  const ProfilePage({super.key, required this.uuid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final authCubit = context.read<AuthCubit>();
  late final profileCubit = context.read<ProfileCubit>();

  late AppUser? currentUser = authCubit.currentUser;
  @override
  void initState() {
    super.initState();
    setState(() {
      profileCubit.getUserProfile(widget.uuid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          final user = state.user;
          return Scaffold(
            appBar: AppBar(
              title: Text(user.name),
              foregroundColor: Theme.of(context).colorScheme.primary,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      user.email,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    //Profile image
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      height: 120,
                      width: 120,
                      padding: const EdgeInsets.all(25),
                      child: Center(
                        child: Icon(
                          Icons.person,
                          size: 72,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        Text(
                          "Bio",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    BioBox(text: user.bio)
                  ],
                ),
              ),
            ),
          );
        } else if (state is ProfileLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Text("Profile user not found"),
            ),
          );
        }
      },
    );
  }
}
