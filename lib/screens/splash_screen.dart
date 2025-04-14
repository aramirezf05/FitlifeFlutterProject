import 'dart:async';
import 'package:fitlife/main.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';
import '../utils/string_constants.dart';

const logoPath = "assets/images/FitLifeLogo.png";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => MyHomePage(title: "FitLife", user: User(
            firstName: "firstName",
            lastName: "lastName",
            email: "email",
            password: "password",
            username: 'username',
          )),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(logoPath),
            Text(
              appTitle,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}