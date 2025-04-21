import 'package:fitlife/screens/settings/settings_screen.dart';
import 'package:fitlife/screens/splash_screen.dart';
import 'package:fitlife/screens/workout/exercise/exercise_card.dart';
import 'package:fitlife/screens/workout/routine/routine_card.dart';
import 'package:fitlife/screens/workout/routine/routine_detail.dart';
import 'package:fitlife/utils/string_constants.dart';
import 'package:flutter/material.dart';
import 'model/routine.dart';
import 'model/user.dart';
import 'model/exercise.dart';

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
  const MyHomePage({super.key, required this.title, required this.user});

  final String title;
  final User user;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  Future<List<Exercise>>? _exercises;
  String? _selectedMuscle;

  void _fetchExercises(String muscle) {
    setState(() {
      _exercises = Exercise.fetchExercisesByMuscle(muscle);
    });
  }

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _onSettingsPressed() {
    Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => SettingsScreen(user: widget.user,),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: _selectedIndex == 0 ? _buildHomeBody() : _buildWorkoutBody(),
    );
  }

  Widget _buildHomeBody() {
    if (widget.user.routines.isEmpty) {
      return Center(child: Text('No routines found'));
    }

    return ListView.builder(
      itemCount: widget.user.routines.length,
      itemBuilder: (context, index) {
        final routine = widget.user.routines[index];
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(routine.name),
            subtitle: Text('Exercises: ${routine.exercises.length}'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => RoutineDetail(
                    user: widget.user,
                    routine: routine,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildWorkoutBody() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: DropdownButton<String>(
            value: _selectedMuscle,
            hint: Text('Select Muscle'),
            items: Exercise.musclesList.map((String muscle) {
              return DropdownMenuItem<String>(
                value: muscle,
                child: Text(muscle),
              );
            }).toList(),
            onChanged: (String? newMuscle) {
              setState(() {
                _selectedMuscle = newMuscle;
                _fetchExercises(_selectedMuscle!);
              });
            },
          ),
        ),
        Expanded(child: _exercises == null ? Center(child: Text('Search for exercises')) : _buildExerciseBody()),
      ],
    );
  }

  Widget _buildExerciseBody() {
    return FutureBuilder<List<Exercise>>(
      future: _exercises,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error.toString()}'));
        } else if (snapshot.hasData) {
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: snapshot.data!.map((exercise) => ExerciseCard(exercise: exercise, icon: Icons.sports_mma, user: widget.user)).toList(),
          );
        } else {
          return Center(child: Text('No exercise data found'));
        }
      },
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

  List<Widget> generateExerciseCards(Exercise exercise, User user) {
    List<Widget> cards = [];
    cards.add(
      ExerciseCard(
          exercise: exercise,
          icon: Icons.sports_mma,
          user: user,
      ),
    );
    return cards;
  }
}