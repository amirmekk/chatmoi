import 'package:chatmoi/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Moi!'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            AuthMethods().signInWithGoole(context);
          },
          child: const Text('Sign In With Google'),
        ),
      ),
    );
  }
}
