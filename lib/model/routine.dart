import 'package:fitlife/model/exercise.dart';

class Routine {
  final String id;
  final String name;
  final String description;
  final List<Exercise> exercises;
  late int sets;
  late int reps;
  late int duration;

  Routine({
    required this.id,
    required this.name,
    required this.description,
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