import 'package:flutter/material.dart';
import 'package:t_store/user_module/features/personalization/screens/training/widgets/trainers/widgets/trainer_item.dart';

class TrainerCard extends StatelessWidget {
  final TrainerItem trainerItem;

  const TrainerCard({required this.trainerItem, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 100, // Size for the circular image
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[300],
            image: DecorationImage(
              image: AssetImage(trainerItem.imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8), // Spacing between image and name
        Text(
          trainerItem.name,
          style: const TextStyle(
            fontSize: 14, // Adjusted font size for names
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4), // Spacing between name and subtitle
        Text(
          trainerItem.subtitle,
          style: const TextStyle(
            fontSize: 8, // Smaller font size for subtitle
            color: Colors.grey, // Subtitle color
          ),
          textAlign: TextAlign.center,
          maxLines: 2, // Limit subtitle to 2 lines
          overflow: TextOverflow.ellipsis, // Add ellipsis if text overflows
        ),
      ],
    );
  }
}
