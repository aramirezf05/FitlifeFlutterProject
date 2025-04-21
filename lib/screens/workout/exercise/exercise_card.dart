import 'package:flutter/material.dart';
import 'package:fitlife/model/exercise.dart';

import '../../../model/user.dart';
import 'exercise_detail.dart';

class ExerciseCard extends StatelessWidget {
  final Exercise exercise;
  final IconData icon;
  final User user;


  const ExerciseCard({
    super.key,
    required this.exercise,
    required this.icon,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlue.shade50,
      child: InkWell(
        onTap: () => _handleCardTap(context, exercise),
        child: Column (
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(icon),
              title: Text(exercise.name),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: Row(
                    children: const [
                      Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 25,
                      ),
                    ],
                  ),
                  onPressed: () {
                    _displayDeleteWorkoutPopUp();
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _handleCardTap(BuildContext context, Exercise exercise) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ExerciseDetail(
            exercise: exercise,
            user: user
        ),
      ),
    );
  }

  void _displayDeleteWorkoutPopUp() {
    //TODO
  }
}