import 'package:fitlife/model/exercise.dart';
import 'package:fitlife/screens/workout/exercise_detail.dart';
import 'package:fitlife/screens/workout/workout_detail.dart';
import 'package:flutter/material.dart';

Widget addWorkoutButton() {
  return FloatingActionButton(
    onPressed: () {

    },
    backgroundColor: Colors.red,
    child: Icon(Icons.add),
  );
}

class Workout extends StatelessWidget {
  final Exercise exercise;
  final IconData icon;

  const Workout({required this.exercise, required this.icon, super.key});

  void _displayDeleteWorkoutPopUp() {

  }

  void _handleCardTap(BuildContext context, Exercise exercise) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ExerciseDetail(
          exercise: exercise,
        ),
      ),
    );
  }

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
}



List<Widget> generateCards(Exercise exercise) {
  List<Widget> cards = [];
  cards.add(
    Workout(
      exercise: exercise,
      icon: Icons.sports_mma,
    ),
  );
  return cards;
}