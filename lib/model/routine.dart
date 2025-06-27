import 'package:fitlife/model/exercise.dart';

class Routine {
  final String id;
  String name = "Default Routine";
  final List<Exercise> exercises;
  late int sets;
  late int reps;
  late int duration;

  Routine({
    required this.id,
    required this.name,
    required this.exercises,
    this.sets = 0,
    this.reps = 0,
  });

  void addExercise(Exercise exercise) {
    exercises.add(exercise);
  }

  void removeExercise(Exercise exercise) {
    exercises.remove(exercise);
  }
}