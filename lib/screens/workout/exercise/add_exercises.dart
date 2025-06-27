
import 'package:flutter/material.dart';

import '../../../model/exercise.dart';
import '../../../model/routine.dart';
import '../../../model/user.dart';
import '../../../utils/fitlife_app_bar.dart';
import '../../../utils/string_constants.dart';
import 'exercise_card.dart';

class AddExercisesScreen extends StatefulWidget {
  final Routine routine;
  final User user;

  AddExercisesScreen({required this.routine, required this.user});

  @override
  _AddExercisesScreenState createState() => _AddExercisesScreenState();
}

class _AddExercisesScreenState extends State<AddExercisesScreen> {
  String? _selectedMuscle;
  Future<List<Exercise>>? _futureExercises;
  Map<Exercise, bool> selectedExercises = {};

  @override
  void initState() {
    super.initState();
  }

  void _fetchExercises(String target) {
    setState(() {
      _futureExercises = Exercise.fetchExercisesByTarget(target);
    });
  }

  void _confirmAndReturn() {
    final selected = selectedExercises.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
    Navigator.pop(context, selected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FitLifeAppBar(title: 'Add exercises'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButton<String>(
              value: _selectedMuscle,
              hint: Text('Select Muscle'),
              items: Exercise.musclesList
                  .map((String muscle) => DropdownMenuItem<String>(
                value: muscle,
                child: Text(capitalizeFirstLetter(muscle)),
              ))
                  .toList(),
              onChanged: (String? newMuscle) {
                if (newMuscle != null) {
                  _fetchExercises(newMuscle);
                  _selectedMuscle = newMuscle;
                }
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Exercise>>(
              future: _futureExercises,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final exercises = snapshot.data!;
                  for (var exercise in exercises) {
                    if (!selectedExercises.containsKey(exercise)) {
                      selectedExercises[exercise] = false;
                    }
                  }
                  return ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: exercises.map((exercise) {
                      final isSelected = selectedExercises[exercise] ?? false;
                      return ExerciseCard(
                        exercise: exercise,
                        user: widget.user,
                        isSelected: isSelected,
                        onSelected: (bool? value) {
                          setState(() {
                            selectedExercises[exercise] = value ?? false;
                          });
                        },
                      );
                    }).toList(),
                  );
                } else {
                  return Center(child: Text('No exercises found'));
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.check),
        label: Text('Add selected'),
        onPressed: _confirmAndReturn,
      ),
    );
  }
}
