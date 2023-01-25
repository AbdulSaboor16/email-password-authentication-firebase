import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:working/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            TextFormField(
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
                    UserCredential userCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      showDialog(
                        barrierDismissible: false,
                          context: context,
                          builder: (_) => AlertDialog(
                                title:
                                    Text("The password provided is too weak."),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Ok"))
                                ],
                              ));
                    } else if (e.code == 'email-already-in-use') {
                      showDialog(
                       barrierDismissible: false,
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text(
                              "The account already exists for that email."),
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
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text("Create Account")),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: Text("Sign Up"))
          ],
        ),
      ),
    );
  }
}
