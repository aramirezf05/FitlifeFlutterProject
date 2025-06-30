
import 'package:fitlife/model/routine.dart';

class User {
  late String firstName;
  late String lastName;
  late String email;
  late String username;
  final String password;
  late double weight;
  late double height;
  late List<Routine> routines;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.password,
    this.weight = 0.0,
    this.height = 0.0,
    routines,
  }) : routines = routines ?? [];

  void addRoutine(Routine routine) {
    routines.add(routine);
  }

  void removeRoutine(Routine routine) {
    routines.remove(routine);
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'username': username,
      'password': password,
      'weight': weight,
      'height': height,
      'routines': routines.map((r) => r.toJson()).toList(),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      username: json['username'],
      password: json['password'],
      weight: (json['weight'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      routines: (json['routines'] as List<dynamic>)
          .map((r) => Routine.fromJson(r))
          .toList(),
    );
  }
}

