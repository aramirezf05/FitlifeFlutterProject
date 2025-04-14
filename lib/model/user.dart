
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
}

class UserManager {
  final List<User> _registeredUsers = [];

  void registerUser(User user) {
    _registeredUsers.add(user);
  }

  User? login(String username, String password) {
    for (var user in userManager.registeredUsers) {
      print('User: ${user.username}');
    }
    for (var user in _registeredUsers) {
      if (user.username == username && user.password == password) {
        return user;
      }
    }
    return null;
  }

  List<User> get registeredUsers => _registeredUsers;
}

final userManager = UserManager();