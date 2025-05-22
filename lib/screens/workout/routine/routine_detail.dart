import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../model/routine.dart';
import '../../../model/user.dart';
import '../../../utils/fitlife_app_bar.dart';
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
    routineDescriptionController.text = widget.routine.description;
    exercisesController.text = widget.routine.exercises.join(', ');
    seriesController.text = widget.routine.sets.toString();
    repetitionsController.text = widget.routine.reps.toString();
    _ticker = Ticker(_onTick);

    for (var exercise in widget.routine.exercises) {
      exerciseSets[exercise.name] = [];
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
      appBar: FitLifeAppBar(title: widget.routine.name),
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
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () => _confirmDeleteRoutine(widget.routine),
                child: Text('Delete routine', style: TextStyle(color: Colors.white)),
              ),

            ),
            SizedBox(height: 20),
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
        final sets = exerciseSets[exercise.name]!;

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(exercise.name, style: TextStyle(fontWeight: FontWeight.bold)),
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
                ElevatedButton(
                  onPressed: () => _addSerieDialog(exercise.name),
                  child: Text("Add set"),
                ),
              ],
            ),
          ),
        );
      },

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
}