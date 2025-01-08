import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TTrainerCard extends StatelessWidget {
  final String planName;
  final String trainerName;
  final bool isActive;
  final String? startDate;
  final String? endDate;
  final String? profilePic;
  final String workouts;
  final String? price;
  final int? duration;

  const TTrainerCard({
    super.key,
    required this.planName,
    required this.trainerName,
    required this.isActive,
    this.startDate,
    this.endDate,
    this.profilePic,
    required this.workouts,
    this.price,
    this.duration,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final dark = THelperFunctions.isDarkMode(context);

    return Container(
      constraints: const BoxConstraints(minHeight: 200),
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        image: DecorationImage(
            image: const AssetImage(TImages.guidanceImage2), // Background image
            fit: BoxFit.cover,
            colorFilter: dark
                ? ColorFilter.mode(
                    Colors.black.withOpacity(0.2), // Add dark overlay
                    BlendMode.darken,
                  )
                : null),
      ),
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.transparent, // Transparent to show background image
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Profile Picture
              ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Image.network(
                  profilePic?.isNotEmpty ?? false
                      ? profilePic!
                      : TImages.userProfileImage1,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 15),
              // Trainer Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Trainer's Name
                    Text(
                      trainerName,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    // Plan Name
                    Text(
                      "Plan Name: $planName",
                      style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    // Workout Style
                    Text(
                      'Style: $workouts',
                      style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    if (isActive) ...[
                      // Display Start and End Date
                      _buildDetailText(
                          'Start Date', startDate, TColors.primary),
                      _buildDetailText('End Date', endDate, TColors.primary),
                    ] else if (price != null) ...[
                      // Show Duration
                      _buildDetailText(
                        'Duration',
                        duration != null ? '$duration months' : 'Not available',
                        TColors.primary,
                      ),
                      const SizedBox(height: 10),
                      // Display "Join for" Price
                      _buildJoinForPrice(price!, TColors.primary),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to build detail rows
  Widget _buildDetailText(String label, String? value, Color colorScheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        '$label: ${value ?? "Not available"}',
        style: TextStyle(
          color: colorScheme,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Helper function to display "Join for" price
  Widget _buildJoinForPrice(String price, Color color) {
    return Text(
      'Join for $price Rs/month',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }
}
