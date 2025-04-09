import 'package:fitlife/utils/fitlife_app_bar.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../model/user.dart';
import '../../utils/fitlife_input_textfield.dart';
import '../../utils/number_constants.dart';
import '../../utils/string_constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _checkCredentials() {
    if (_firstNameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _usernameController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      return;
    } else if (_passwordController.text.length < sizeInt_4) {
      print('Password must be at least 4 characters long');
      return;
    } else if (!_emailController.text.contains('@')) {
      print('Invalid email address');
      return;
    } else {
      _attemptRegister();
    }
  }

  void _attemptRegister() {
    final user = User(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: _emailController.text,
      username: _usernameController.text,
      password: _passwordController.text,
    );

    userManager.registerUser(user);
    print('Registration successful');
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => MyHomePage(title: appTitle, user: user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FitLifeAppBar(title: appTitle, showBackButton: false,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            fitLifeTextField(controller: _firstNameController, labelText: "First Name", prefixIcon: Icons.person, context: context),
            SizedBox(height: 16),
            fitLifeTextField(controller: _lastNameController, labelText: "Last Name", prefixIcon: Icons.person, context: context),
            SizedBox(height: 16),
            fitLifeEmailTextField(controller: _emailController, labelText: "Email", prefixIcon: Icons.email, context: context),
            SizedBox(height: 16),
            fitLifeTextField(controller: _usernameController, labelText: "Username", prefixIcon: Icons.person, context: context),
            SizedBox(height: 16),
            fitLifePasswordTextField(controller: _passwordController, labelText: "Password", prefixIcon: Icons.lock, context: context),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _checkCredentials,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Register',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}