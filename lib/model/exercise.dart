import 'dart:convert';
import '../api/responses.dart';
import 'package:http/http.dart' as http;

class Exercise {
  final String id;
  final String name;
  final String category;
  final String equipment;
  final String force;
  final String mechanic;
  final String level;
  final List<String> primaryMuscles;
  final List<String> secondaryMuscles;
  final List<String> instructions;
  final List<String> images;
  late double liftedWeight;
  late int sets;
  late int reps;

  Exercise({
    required this.id,
    required this.name,
    required this.category,
    required this.equipment,
    required this.force,
    required this.mechanic,
    required this.level,
    required this.primaryMuscles,
    required this.secondaryMuscles,
    required this.instructions,
    required this.images,
    this.liftedWeight = 0.0,
    this.sets = 0,
    this.reps = 0,
  });

  static final List<String> musclesList = [
    "quadriceps",
    "shoulders",
    "abdominals",
    "chest",
    "hamstrings",
    "triceps",
    "biceps",
    "lats",
    "middle_back",
    "forearms",
    "glutes",
    "traps",
    "adductors",
    "abductors",
    "neck"
  ];

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      category: json['category'] as String? ?? '',
      equipment: json['equipment'] as String? ?? '',
      force: json['force'] as String? ?? '',
      id: json['id'] as String? ?? '',
      images: (json['images'] as List<dynamic>?)
              ?.map((image) => image as String)
              .toList() ??
          [],
      instructions: (json['instructions'] as List<dynamic>?)
              ?.map((instruction) => instruction as String)
              .toList() ??
          [],
      level: json['level'] as String? ?? '',
      mechanic: json['mechanic'] as String? ?? '',
      name: json['name'] as String? ?? '',
      primaryMuscles: (json['primaryMuscles'] as List<dynamic>?)
              ?.map((muscle) => muscle as String)
              .toList() ??
          [],
      secondaryMuscles: (json['secondaryMuscles'] as List<dynamic>?)
              ?.map((muscle) => muscle as String)
              .toList() ??
          [],
    );
  }

  static Future<List<Exercise>> fetchExercisesByMuscle(String muscle) async {
    final Uri uri = Uri.parse('https://exercise-db-fitness-workout-gym.p.rapidapi.com/exercises/muscle/$muscle');

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<dynamic> exercisesJson = jsonDecode(response.body);
      return exercisesJson
          .map((json) => Exercise.fromJson(json as Map<String, dynamic>))
          .where((exercise) => exercise.primaryMuscles.contains(muscle))
          .toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load exercises');
    }
  }
}

final Map<String, String> headers = {
  'X-RapidAPI-Key': apiRapidApiKey,
  'X-RapidAPI-Host': apiRapidApiHost,
};