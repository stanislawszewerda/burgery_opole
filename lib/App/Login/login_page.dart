//import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    Key? key,
  }) : super(key: key);

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Zaloguj się'),
            const SizedBox(
              height: 50,
            ),
            TextField(
              decoration: const InputDecoration(hintText: 'E-mail'),
              controller: widget.emailController,
            ),
            TextField(
              decoration: const InputDecoration(hintText: 'hasło'),
              obscureText: true,
              controller: widget.passwordController,
            ),
            const SizedBox(
              height: 100,
            ),
            Text(errorMessage),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: widget.emailController.text,
                      password: widget.passwordController.text,
                    );
                  } catch (error) {
                    setState(() {
                      errorMessage = error.toString();
                    });
                    print(error);
                  }
                },
                child: const Text('Zaloguj się')),
          ],
        ),
      ),
    ));
  }
}
