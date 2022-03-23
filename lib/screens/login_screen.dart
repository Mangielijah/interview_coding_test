import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interview_new_startup/services/auth_service.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    final authService = ref.read(authServiceProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "Password",
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              authService.signInWithEmailAndPassword(
                emailController.text,
                passwordController.text,
              );
            },
            child: Text('Login'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/register');
            },
            child: Text('Register'),
          ),
        ],
      ),
    );
  }
}
