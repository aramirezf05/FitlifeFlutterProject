
import 'dart:convert';

import 'package:fitlife/model/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserManager {
  final List<User> _registeredUsers = [];

  Future<void> saveUsers() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> usersJson = _registeredUsers.map((u) => jsonEncode(u.toJson())).toList();
    await prefs.setStringList('users', usersJson);
  }

  Future<void> loadUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getStringList('users') ?? [];
    _registeredUsers.clear();
    for (var userStr in usersJson) {
      final Map<String, dynamic> userMap = jsonDecode(userStr);
      _registeredUsers.add(User.fromJson(userMap));
    }
  }

  Future<void> initialize() async {
    await loadUsers();
  }

  Future<void> registerUser(User user) async {
    final existingUser = _registeredUsers.any((u) => u.username == user.username);
    if (existingUser) {
      SnackBar(
        content: Text('Username ${user.username} is already taken.'),
      );
      return;
    }
    _registeredUsers.add(user);
    await saveUsers();
  }

  User? login(String username, String password) {
    for (var user in _registeredUsers) {
      print('User: ${user.username}');
      if (user.username == username && user.password == password) {
        return user;
      }
    }
    return null;
  }

  List<User> get registeredUsers => _registeredUsers;
}

final userManager = UserManager();