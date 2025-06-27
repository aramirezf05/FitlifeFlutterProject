import 'package:fitlife/model/user.dart';
import 'package:fitlife/utils/fitlife_app_bar.dart';
import 'package:fitlife/utils/string_constants.dart';
import 'package:flutter/material.dart';
import '../../../model/exercise.dart';
class ExerciseDetail extends StatefulWidget {
  const ExerciseDetail({super.key, required this.exercise, required this.user});

  final Exercise exercise;
  final User user;

  @override
  State<ExerciseDetail> createState() => _ExerciseDetailState();
}

class _ExerciseDetailState extends State<ExerciseDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FitLifeAppBar(
        title: appTitle
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    capitalizeFirstLetter(widget.exercise.name),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildGifCard('Exercise Preview', widget.exercise.gifUrl),
            _buildDetailCard('Description', capitalizeFirstLetter(widget.exercise.description)),
            _buildDetailCard('Difficulty', capitalizeFirstLetter(widget.exercise.difficulty)),
            _buildDetailCard('Category', capitalizeFirstLetter(widget.exercise.category)),
            _buildDetailCard('Equipment', capitalizeFirstLetter(widget.exercise.equipment)),
            _buildDetailCard('Primary Muscles', capitalizeFirstLetter(widget.exercise.bodyPart)),
            _buildMusclesCard('Secondary Muscles', widget.exercise.secondaryMuscles),
            _buildInstructionsCard('Instructions', widget.exercise.instructions),
          ],
        ),
      ),
    );
  }

  Widget _buildGifCard(String title, String gifUrl) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Center(
            child: Image.network(
              gifUrl,
              height: 200,
              errorBuilder: (context, error, stackTrace) {
                return Text('Could not load exercise preview');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
          ),
        ],
      ),
    );
  }


  Widget _buildDetailCard(String title, String detail) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(title),
        subtitle: Text(detail.isEmpty ? 'Not available' : detail),
      ),
    );
  }

  Widget _buildMusclesCard(String title, List<String> muscles) {
    final List<String> formattedMuscles = muscles.map((muscle) => capitalizeFirstLetter(muscle)).toList();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(title),
        subtitle: Text(muscles.isEmpty ? 'Not available' : formattedMuscles.join(', ')),
      ),
    );
  }

  Widget _buildInstructionsCard(String title, List<String> instructions) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: instructions.isEmpty
              ? [Text('Not available')]
              : instructions.map((instruction) => Text('- $instruction')).toList(),
        ),
      ),
    );
  }

}
