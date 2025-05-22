
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../model/exercise.dart';
import '../../../model/routine.dart';
import '../../../model/user.dart';

class CreateRoutineFormScreen extends StatelessWidget {
  final User user;
  final List<Exercise> selectedExercises;

  const CreateRoutineFormScreen({
    super.key,
    required this.user,
    required this.selectedExercises,
  });

  @override
  Widget build(BuildContext context) {
    final routineNameController = TextEditingController();
    final routineDescriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('Create Routine')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: routineNameController,
              decoration: InputDecoration(labelText: 'Routine Name'),
            ),
            TextField(
              controller: routineDescriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            ElevatedButton(
              onPressed: () {
                final newRoutine = Routine(
                  id: DateTime.now().toString(),
                  name: routineNameController.text,
                  description: routineDescriptionController.text,
                  exercises: selectedExercises,
                );
                user.addRoutine(newRoutine);
                Navigator.pop(context);
              },
              child: Text('Save Routine'),
            ),
          ],
        ),
      ),
    );
  }
}