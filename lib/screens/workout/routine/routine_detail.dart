import 'package:fitlife/utils/number_constants.dart';
import 'package:flutter/material.dart';

import '../../../model/routine.dart';
import '../../../model/user.dart';
import '../../../utils/fitlife_app_bar.dart';
import '../../../utils/fitlife_input_textfield.dart';
import '../../../utils/string_constants.dart';

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

  @override
  void initState() {
    super.initState();
    routineNameController.text = widget.routine.name;
    routineDescriptionController.text = widget.routine.description;
    exercisesController.text = widget.routine.exercises.join(', ');
    seriesController.text = widget.routine.sets.toString();
    repetitionsController.text = widget.routine.reps.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FitLifeAppBar(title: appTitle),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: <Widget>[
              fitLifeTextField(controller: routineNameController, labelText: "Routine name", prefixIcon: Icons.sports_mma, context: context),
              SizedBox(height: sizeDouble_8),
              fitLifeTextField(controller: routineDescriptionController, labelText: "Description", prefixIcon: Icons.sports_mma, context: context),
              TextFormField(
                controller: exercisesController,
                decoration: InputDecoration(labelText: 'Exercise list'),
              ),
              TextFormField(
                controller: seriesController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Sets'),
              ),
              TextFormField(
                controller: repetitionsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Repetitions'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _saveChanges();
                },
                child: Text('Save changes'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _deleteWorkout();
                },
                child: Text('Delete'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveChanges() {
    print('Cambios guardados');
  }

  void _deleteWorkout() {
    print('Rutina eliminada');
  }


}