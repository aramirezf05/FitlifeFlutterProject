import 'package:fitlife/screens/settings/settings_screen.dart';
import 'package:fitlife/screens/splash_screen.dart';
import 'package:fitlife/screens/workout/workout_widgets.dart';
import 'package:fitlife/utils/string_constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) {
    return context.findAncestorStateOfType<_MyAppState>()!;
  }
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: Colors.lightBlue,
          secondary: Colors.black,
          tertiary: Colors.blue,
          brightness: Brightness.light
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: Colors.deepPurple,
          secondary: Colors.black,
          tertiary: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
    themeMode: _themeMode,
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  final List<Widget> _widgetOptions = <Widget>[
    ListView(
      padding: const EdgeInsets.all(16.0),
      children: generateCards(10), // Genera 10 Cards
    ),
    Center(child: null)
  ];

  void _onSettingsPressed() {
    Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => SettingsScreen(),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: _widgetOptions[_selectedIndex],
      floatingActionButton: addWorkoutButton(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Text(widget.title),
      leading: Container(), // Empty container to remove the default back button
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: _onSettingsPressed,
        ),
      ],
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: homeLabel,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outline_sharp),
          label: workoutLabel,
        ),

      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      showUnselectedLabels: true,
      backgroundColor: Colors.white,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Theme.of(context).colorScheme.secondary,
    );
  }
}