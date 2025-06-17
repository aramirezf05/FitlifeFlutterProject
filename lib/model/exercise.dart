import 'dart:convert';
import '../api/responses.dart';
import 'package:http/http.dart' as http;

class Exercise {
  final String id;
  final String name;
  final String bodyPart;
  final String equipment;
  final String gifUrl;
  final String target;
  final List<String> secondaryMuscles;
  final List<String> instructions;
  final String description;
  final String difficulty;
  final String category;

  late double liftedWeight;
  late int sets;
  late int reps;

  Exercise({
    required this.id,
    required this.name,
    required this.bodyPart,
    required this.equipment,
    required this.gifUrl,
    required this.target,
    required this.secondaryMuscles,
    required this.instructions,
    required this.description,
    required this.difficulty,
    required this.category,
    this.liftedWeight = 0.0,
    this.sets = 0,
    this.reps = 0,
  });

  static const List<String> musclesList = [
    "abductors", "abs", "adductors", "biceps", "calves", "cardiovascular system",
    "delts", "forearms", "glutes", "hamstrings", "lats", "levator scapulae",
    "pectorals", "quads", "serratus anterior", "spine", "traps", "triceps", "upper back"
  ];


  static const validBodyParts = [
    "back", "cardio", "chest", "lower arms", "lower legs", "neck",
    "shoulders", "upper arms", "upper legs", "waist"
  ];

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      bodyPart: json['bodyPart'] ?? '',
      equipment: json['equipment'] ?? '',
      gifUrl: json['gifUrl'] ?? '',
      target: json['target'] ?? '',
      secondaryMuscles: List<String>.from(json['secondaryMuscles'] ?? []),
      instructions: List<String>.from(json['instructions'] ?? []),
      description: json['description'] ?? '',
      difficulty: json['difficulty'] ?? '',
      category: json['category'] ?? '',
    );
  }

  static Future<List<Exercise>> fetchExercisesByTarget(String target) async {
    final uri = Uri.parse('https://exercisedb.p.rapidapi.com/exercises/target/$target');
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Exercise.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener ejercicios por target');
    }
  }

  static Future<List<Exercise>> fetchExercisesByBodyPart(String bodyPart) async {
    final uri = Uri.parse('https://exercisedb.p.rapidapi.com/exercises/bodyPart/$bodyPart');
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Exercise.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener ejercicios por bodyPart');
    }
  }

}


final Map<String, String> headers = {
  'X-RapidAPI-Key': apiRapidApiKey,
  'X-RapidAPI-Host': apiRapidApiHost,
};