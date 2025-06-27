import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../model/exercise.dart';
import '../../../model/routine.dart';
import '../../../model/user.dart';
import '../../../utils/fitlife_app_bar.dart';
import '../../../utils/string_constants.dart';
import '../exercise/add_exercises.dart';
import '../exercise/exercise_detail.dart';

class RoutineDetail extends StatefulWidget {
  const RoutineDetail({super.key, required this.routine, required this.user});

  final User user;
  final Routine routine;

  @override
  State<StatefulWidget> createState() {
    return _RoutineDetailState();
  }
}

class _RoutineDetailState extends State<RoutineDetail> {
  final TextEditingController routineNameController = TextEditingController();
  final TextEditingController routineDescriptionController = TextEditingController();
  final TextEditingController exercisesController = TextEditingController();
  final TextEditingController seriesController = TextEditingController();
  final TextEditingController repetitionsController = TextEditingController();

  bool isRoutineRunning = false;
  int elapsedSeconds = 0;
  late final Ticker _ticker;
  Map<String, List<Map<String, int>>> exerciseSets = {};

  @override
  void initState() {
    super.initState();
    routineNameController.text = widget.routine.name;
    exercisesController.text = widget.routine.exercises.join(', ');
    seriesController.text = widget.routine.sets.toString();
    repetitionsController.text = widget.routine.reps.toString();
    _ticker = Ticker(_onTick);

    for (var exercise in widget.routine.exercises) {
      exerciseSets[capitalizeFirstLetter(exercise.name)] = [];
    }
  }

  void _onTick(Duration elapsed) {
    setState(() {
      elapsedSeconds = elapsed.inSeconds;
    });
  }

  void _startRoutine() {
    setState(() {
      isRoutineRunning = true;
      elapsedSeconds = 0;
    });
    _ticker.start();
  }

  void _stopRoutine() {
    setState(() {
      isRoutineRunning = false;
    });
    _ticker.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FitLifeAppBar(
        title: widget.routine.name,
        actions: [
          IconButton(
          icon: Icon(Icons.edit),
          tooltip: 'Rename routine',
          onPressed: () {
            _showRenameDialog();
          },
    ),
    ],),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddExercisesScreen(
                routine: widget.routine,
                user: widget.user,
              ),
            ),
          ).then((value) {
            if (value != null && value is List<Exercise>) {
              setState(() {
                for (var newEx in value) {
                  final exists = widget.routine.exercises.any(
                          (existing) => existing.name.toLowerCase() == newEx.name.toLowerCase()
                  );
                  if (!exists) {
                    widget.routine.exercises.add(newEx);
                  }
                  else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Exercise ${capitalizeFirstLetter(newEx.name)} already exists in the routine')),
                    );
                  }
                }
                for (var exercise in widget.routine.exercises) {
                  final key = capitalizeFirstLetter(exercise.name);
                  if (!exerciseSets.containsKey(key)) {
                    exerciseSets[key] = [];
                  }
                }
              });
            }
          });
        },
        icon: Icon(Icons.add),
        label: Text('Add exercises'),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () => _confirmDeleteRoutine(widget.routine),
          child: Text('Delete routine', style: TextStyle(color: Colors.white)),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (isRoutineRunning)
              Text(
                'Time: ${elapsedSeconds ~/ 60}:${(elapsedSeconds % 60).toString().padLeft(2, '0')}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: isRoutineRunning ? null : _startRoutine,
                  child: Text('Start timer', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: isRoutineRunning ? _stopRoutine : null,
                  child: Text('Stop timer', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: _buildExerciseList(),
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildExerciseList() {
    return ListView.builder(
      itemCount: widget.routine.exercises.length,
      itemBuilder: (context, index) {
        final exercise = widget.routine.exercises[index];
        final sets = exerciseSets[capitalizeFirstLetter(exercise.name)]!;

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(capitalizeFirstLetter(exercise.name), style: TextStyle(fontWeight: FontWeight.bold)),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ExerciseDetail(
                          exercise: exercise,
                          user: widget.user,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 8),
                Column(
                  children: List.generate(sets.length, (i) {
                    final set = sets[i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      child: Text("Set ${i + 1}: ${set['reps']} reps - ${set['kg']} kg"),
                    );
                  }),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _addSerieDialog(capitalizeFirstLetter(exercise.name)),
                      icon: Icon(Icons.add),
                      label: Text("Add set"),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => _removeExerciseFromRoutine(index),
                      icon: Icon(Icons.delete, color: Colors.white),
                      label: Text("Remove", style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _removeExerciseFromRoutine(int index) {
    setState(() {
      final removedExercise = widget.routine.exercises.removeAt(index);
      exerciseSets.remove(capitalizeFirstLetter(removedExercise.name));
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Exercise removed from routine')),
    );
  }

  void _addSerieDialog(String exerciseName) {
    final repetitionsController = TextEditingController();
    final weightController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add set'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: repetitionsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Repetitions'),
              ),
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Weight (kg)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final reps = int.tryParse(repetitionsController.text);
                final kg = int.tryParse(weightController.text);
                if (reps != null && kg != null) {
                  setState(() {
                    exerciseSets[exerciseName]?.add({"reps": reps, "kg": kg});
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _confirmDeleteRoutine(Routine routine) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete routine'),
        content: Text('Are you sure you want to delete this routine?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                widget.user.routines.remove(routine);
              });

              Navigator.pop(context, true);
              Navigator.pop(context, true);
            },
            child: Text('Confirm', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showRenameDialog() {
    final TextEditingController _nameController = TextEditingController(text: widget.routine.name);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Rename Routine'),
          content: TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'New name'),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: Text('Rename'),
              onPressed: () {
                final newName = _nameController.text.trim();
                if (newName.isNotEmpty) {
                  setState(() {
                    widget.routine.name = newName;
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}