import 'package:flutter/material.dart';
import 'package:myapp/featurs/post/presentation.pages/componenets/my_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: const Center(
        child: Text("Home"),
      ),
      drawer: const MyDrawer(),
    );
  }
}
