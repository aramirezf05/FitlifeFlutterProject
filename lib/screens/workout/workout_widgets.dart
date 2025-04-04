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

class CardExample extends StatelessWidget {
  final String title;
  final IconData icon;

  const CardExample({required this.title, required this.icon, super.key});

  void _displayDeleteWorkoutPopUp() {

  }

  void _handleCardTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WorkoutDetail(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlue.shade50,
      child: InkWell(
        onTap: () => _handleCardTap(context),
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
                      Text(
                        'Delete',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.delete,
                        color: Colors.red,
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

List<Widget> generateCards(int count) {
  List<Widget> cards = [];
  for (int i = 0; i < count; i++) {
    cards.add(CardExample(
      title: 'Workout $i',
      icon: Icons.sports_mma,
    ));
  }
  return cards;
}