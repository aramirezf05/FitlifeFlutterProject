import 'package:flutter/material.dart';
import 'package:fitlife/model/exercise.dart';

import '../../../model/user.dart';
import 'exercise_detail.dart';

class ExerciseCard extends StatelessWidget {
  final Exercise exercise;
  final User user;
  final ValueChanged<bool?> onSelected;
  final bool isSelected;

  const ExerciseCard({
    super.key,
    required this.exercise,
    required this.user,
    required this.onSelected,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.tertiary,
      child: InkWell(
        onTap: () => _handleCardTap(context, exercise),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Checkbox(
                    value: isSelected,
                    onChanged: onSelected
                ),
                title: Text(exercise.name),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  void _handleCardTap(BuildContext context, Exercise exercise) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ExerciseDetail(
          exercise: exercise,
          user: user,
        ),
      ),
    );
  }
}