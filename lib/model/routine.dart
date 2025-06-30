import 'package:fitlife/model/exercise.dart';

class Routine {
  final String id;
  String name = "Default Routine";
  final List<Exercise> exercises;
  late int sets;
  late int reps;

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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'exercises': exercises.map((ex) => ex.toJson()).toList(),
      'sets': sets,
      'reps': reps,
    };
  }

  factory Routine.fromJson(Map<String, dynamic> json) {
    return Routine(
      id: json['id'],
      name: json['name'],
      exercises: (json['exercises'] as List<dynamic>)
          .map((e) => Exercise.fromJson(e))
          .toList(),
      sets: json['sets'] ?? 0,
      reps: json['reps'] ?? 0,
    );
  }
}