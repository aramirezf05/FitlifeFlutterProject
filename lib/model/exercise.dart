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
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      equipment: json['equipment'] as String,
      force: json['force'] as String,
      mechanic: json['mechanic'] as String,
      level: json['level'] as String,
      primaryMuscles: List<String>.from(json['primaryMuscles']),
      secondaryMuscles: List<String>.from(json['secondaryMuscles']),
      instructions: List<String>.from(json['instructions']),
      images: List<String>.from(json['images']),
    );
  }

  static Future<Exercise> fetchExerciseById(String id) async {
    final Uri uri = Uri.parse('https://exercise-db-fitness-workout-gym.p.rapidapi.com/exercise/$id');

    final Map<String, String> headers = {
      'X-RapidAPI-Key': apiRapidApiKey,
      'X-RapidAPI-Host': apiRapidApiHost,
    };

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Exercise.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load exercise');
    }
  }

  static Future<Exercise> fetchExerciseFilter(String filter, String parameter) async {
    final Uri uri = Uri.parse('https://exercise-db-fitness-workout-gym.p.rapidapi.com/$filter/$parameter');

    final Map<String, String> headers = {
      'X-RapidAPI-Key': apiRapidApiKey,
      'X-RapidAPI-Host': apiRapidApiHost,
    };

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Exercise.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load exercise');
    }
  }
}