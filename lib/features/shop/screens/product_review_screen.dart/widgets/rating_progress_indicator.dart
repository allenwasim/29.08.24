import 'package:flutter/material.dart';

class TRatingProgressIndicator extends StatelessWidget {
  const TRatingProgressIndicator({
    super.key,
    required this.text,
    required this.value,
  });
  final String text;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: 4.0), // Add space between bars
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
          ),
          Expanded(
            flex: 11,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(7), // Apply rounded corners
              child: LinearProgressIndicator(
                value: value,
                minHeight: 10, // Adjust height to make it look like a bar
                backgroundColor: Colors.grey.shade300,
                valueColor: const AlwaysStoppedAnimation(Colors.green),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
