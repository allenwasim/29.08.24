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
    // Check if dark mode is enabled
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      constraints: BoxConstraints(minHeight: 200),
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        image: DecorationImage(
          image: AssetImage(TImages.guidanceImage2), // Background image
          fit: BoxFit.cover, // Ensure the image covers the entire card
          colorFilter: ColorFilter.mode(
            Colors.black
                .withOpacity(0.5), // Reduce opacity of the background image
            BlendMode.darken,
          ),
        ),
      ),
      child: Card(
        margin: EdgeInsets.zero, // Remove default margin for card
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors
            .transparent, // Set card color to transparent to show background image
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Profile Picture on the Left
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
              // Trainer Info on the Right
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Trainer's Name
                    Text(
                      trainerName,
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    // Plan Name
                    Text(
                      planName,
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Workout Style
                    Text(
                      'Style: $workouts',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (isActive) ...[
                      // Display Start and End Date
                      _buildDetailText('Start Date', startDate, isDarkMode),
                      _buildDetailText('End Date', endDate, isDarkMode),
                    ] else if (price != null) ...[
                      // Show Duration
                      _buildDetailText(
                          'Duration',
                          duration != null
                              ? '$duration months'
                              : 'Not available',
                          isDarkMode),
                      const SizedBox(height: 10),
                      // Display "Join for" Price in larger font
                      _buildJoinForPrice(price!, isDarkMode),
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

  // Helper function to build text rows
  Widget _buildDetailText(String label, String? value, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        '$label: ${value ?? "Not available"}',
        style: TextStyle(
          color: isDarkMode ? TColors.primary : TColors.trainerPrimary,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Helper function to display "Join for" price in a larger font
  Widget _buildJoinForPrice(String price, bool isDarkMode) {
    return Text(
      'Join for $price Rs/month',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }
}
