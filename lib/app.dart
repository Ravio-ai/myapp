import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/featurs/auth/data/firebase_auth_repo.dart';
import 'package:myapp/featurs/auth/presentation/cubits/auth_cubit.dart';
import 'package:myapp/featurs/auth/presentation/pages/auth_page.dart';
import 'package:myapp/themes/light_mode.dart';

class MyApp extends StatelessWidget {
  final authRepo = FirebaseAuthRepo();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(authRepo: authRepo)..checkAuth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        home: const AuthPage(),
      ),
    );
  }
}
