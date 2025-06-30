import 'package:fitlife/main.dart';
import 'package:fitlife/screens/login/register_screen.dart';
import 'package:fitlife/utils/fitlife_input_textfield.dart';
import 'package:fitlife/utils/string_constants.dart';
import 'package:flutter/material.dart';

import '../../model/user.dart';
import '../../model/user_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _attemptLogin() {
    final username = _usernameController.text;
    final password = _passwordController.text;

    final user = userManager.login(username, password);
    if (user != null) {
      print('Login successful: Welcome ${user.firstName}');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => MyHomePage(title: appTitle, user: user,),
        ),
      );
    } else {
      print('Login failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            fitLifeTextField(controller: _usernameController, labelText: "Username", prefixIcon: Icons.person, context: context),
            const SizedBox(height: 16),
            fitLifePasswordTextField(controller: _passwordController, labelText: "Password", prefixIcon: Icons.lock, context: context),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _attemptLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                shadowColor: Colors.blueGrey,
              ),
              child: Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.blueAccent),
                ),
              ),
              child: Text(
                'Register',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}