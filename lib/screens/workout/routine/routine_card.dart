import 'package:flutter/material.dart';
import '../../../model/routine.dart';
import '../../../model/user.dart';

class RoutineCard extends StatelessWidget {
  final Routine routine;
  final IconData icon;
  final User user;

  const RoutineCard({
    super.key,
    required this.routine,
    required this.icon,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(routine.name),
        onTap: () {
          // Handle tap event
        },
      ),
    );
  }
}
