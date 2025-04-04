
class User {
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String password;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.password,
  });
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