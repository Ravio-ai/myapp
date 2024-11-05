import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/featurs/auth/domain/entities/app_user.dart';
import 'package:myapp/featurs/auth/presentation/cubits/auth_cubit.dart';
import 'package:myapp/featurs/profile/presentation/cubits/profile_cubit.dart';

class ProfilePage extends StatefulWidget {
  final String uuid;
  const ProfilePage({super.key, required this.uuid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final authCubit = context.read<AuthCubit>();
  late final profileCubit = context.read<ProfileCubit>();

  late AppUser? user = authCubit.currentUser;
  @override
  void initState() {
    super.initState();
    setState(() {
      profileCubit.getProfileUser(widget.uuid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user!.email),
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
