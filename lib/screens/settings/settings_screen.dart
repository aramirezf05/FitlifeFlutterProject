import 'package:fitlife/main.dart';
import 'package:fitlife/utils/string_constants.dart';
import 'package:fitlife/utils/fitlife_app_bar.dart';
import 'package:flutter/material.dart';
import 'account_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: FitLifeAppBar(
        title: settingsLabel,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text(accountLabel),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AccountScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            title: Text(
              isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
            ),
            onTap: () {
              print("Switch to Dark Mode");
              MyApp.of(context).changeTheme(
                isDarkMode ? ThemeMode.light : ThemeMode.dark,
              );
            },
          ),
        ],
      ),
    );
  }
}