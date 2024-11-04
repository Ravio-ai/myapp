import 'package:flutter/material.dart';
import 'package:myapp/featurs/auth/presentation/componenets/my_button.dart';
import 'package:myapp/featurs/auth/presentation/componenets/my_text_field.dart';

class RegisterPage extends StatefulWidget {
  final void Function() toggleScreen;
  const RegisterPage({super.key, required this.toggleScreen});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Body
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Login
                Icon(
                  Icons.lock_open_rounded,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
                //Welcome back message
                Text(
                  "Let's create an account for you",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 25),
                MyTextField(
                  controller: nameController,
                  hint: "Name",
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                //email textfield
                MyTextField(
                  controller: emailController,
                  hint: "Email",
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: passwordController,
                  hint: "Password",
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: confirmPasswordController,
                  hint: "Confirm Password",
                  obscureText: true,
                ),
                const SizedBox(height: 25),
                //Button
                MyButton(
                  onTap: () {},
                  text: "Register",
                ),
                const SizedBox(height: 50),
                //register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already Register?",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.toggleScreen,
                      child: Text(
                        "Login Now",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
