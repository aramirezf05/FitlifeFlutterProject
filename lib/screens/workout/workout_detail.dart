import 'package:fitlife/utils/number_constants.dart';
import 'package:flutter/material.dart';

import '../../utils/fitlife_app_bar.dart';
import '../../utils/fitlife_input_textfield.dart';
import '../../utils/string_constants.dart';

class WorkoutDetail extends StatelessWidget {
  const WorkoutDetail({super.key, required this.workout});

  final String workout;

  void _saveChanges() {
    print('Cambios guardados');
  }

  void _deleteWorkout() {
    print('Rutina eliminada');
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController routineNameController = TextEditingController();
    final TextEditingController routineDescriptionController = TextEditingController();
    final TextEditingController exercisesController = TextEditingController();
    final TextEditingController seriesController = TextEditingController();
    final TextEditingController repetitionsController = TextEditingController();

    return Scaffold(
      appBar: FitLifeAppBar(title: appTitle),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: <Widget>[
              fitLifeTextField(controller: routineNameController, labelText: "Nombre de la Rutina", prefixIcon: Icons.sports_mma, context: context),
              SizedBox(height: sizeDouble_8),
              fitLifeTextField(controller: routineDescriptionController, labelText: "Descripción de la Rutina", prefixIcon: Icons.sports_mma, context: context),
              TextFormField(
                controller: exercisesController,
                decoration: InputDecoration(labelText: 'Listado de Ejercicios'),
              ),
              TextFormField(
                controller: seriesController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Número de Series'),
              ),
              TextFormField(
                controller: repetitionsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Número de Repeticiones'),
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

}