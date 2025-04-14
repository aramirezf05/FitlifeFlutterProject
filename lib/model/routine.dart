import 'package:fitlife/model/exercise.dart';

class Routine {
  final String id;
  final String name;
  final String description;
  final List<Exercise> exercises;

  Routine({
    required this.id,
    required this.name,
    required this.description,
    required this.exercises,
  });

  void addExercise(Exercise exercise) {
    exercises.add(exercise);
  }

  void removeExercise(Exercise exercise) {
    exercises.remove(exercise);
  }
}