import 'package:fitlife/model/exercise.dart';
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
  final String title;
  final IconData icon;

  const Workout({required this.title, required this.icon, super.key});

  void _displayDeleteWorkoutPopUp() {

  }

  void _handleCardTap(BuildContext context, Workout wortkout) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WorkoutDetail(
          workout: wortkout.title,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlue.shade50,
      child: InkWell(
        onTap: () => _handleCardTap(context, this),
        child: Column (
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(icon),
              title: Text(title),
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



List<Widget> generateCards(String exerciseName) {
  List<Widget> cards = [];
  cards.add(
    Workout(
      title: exerciseName,
      icon: Icons.sports_mma,
    ),
  );
  return cards;
}