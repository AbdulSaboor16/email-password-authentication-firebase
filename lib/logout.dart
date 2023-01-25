import 'package:flutter/material.dart';
import 'package:working/login.dart';

class LogoutPage extends StatefulWidget {
  const LogoutPage({super.key});

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 300,),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginPage()),
                  );
                },
                child: Text("logout"))
          ],
        ),
      ),
    );
  }
}
