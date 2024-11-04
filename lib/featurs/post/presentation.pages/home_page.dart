import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/featurs/auth/presentation/cubits/auth_cubit.dart';
import 'package:myapp/featurs/post/presentation.pages/componenets/my_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: context.read<AuthCubit>().logout,
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
        title: const Text("Home"),
      ),
      body: const Center(
        child: Text("Home"),
      ),
      drawer: const MyDrawer(),
    );
  }
}
