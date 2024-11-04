import 'package:flutter/material.dart';
import 'package:myapp/featurs/post/presentation.pages/componenets/my_drawer_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
              MyDrawerTile(
                title: "H O M E",
                icon: Icons.home,
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
