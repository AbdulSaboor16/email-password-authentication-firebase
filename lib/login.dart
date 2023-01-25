import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:working/logout.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              SizedBox(
                height: 40,
              ),
              TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      UserCredential userCredential = await FirebaseAuth
                          .instance
                          .signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LogoutPage()),
                      );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        showDialog(
                          barrierDismissible: false,
                            context: context,
                            builder: (_) => AlertDialog(
                                  title: Text("No user found for that email."),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Ok"))
                                  ],
                                ));
                      } else if (e.code == 'wrong-password') {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (_) => AlertDialog(
                            title:
                                Text("Wrong password provided for that user."),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Ok"))
                            ],
                          ),
                        );
                      }
                    }
                  },
                  child: Text("Login"))
            ],
          ),
        ),
      ),
    );
  }
}
