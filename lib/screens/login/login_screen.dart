import 'package:fitlife/main.dart';
import 'package:fitlife/screens/login/register_screen.dart';
import 'package:fitlife/utils/fitlife_input_textfield.dart';
import 'package:fitlife/utils/string_constants.dart';
import 'package:flutter/material.dart';

import '../../model/user.dart';

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
                backgroundColor: Colors.blueAccent, // Color de fondo del botón
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12), // Espacio interno
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Bordes redondeados
                ),
                shadowColor: Colors.blueGrey, // Color de la sombra
                elevation: 5, // Núm. de elevación de la sombra
              ),
              child: Text(
                'Login',
                style: TextStyle(
                  color: Colors.white, // Color del texto
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
                backgroundColor: Colors.transparent, // Fondo transparente para el TextButton
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.blueAccent), // Borde del botón
                ),
              ),
              child: Text(
                'Register',
                style: TextStyle(
                  color: Colors.blueAccent, // Color del texto
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