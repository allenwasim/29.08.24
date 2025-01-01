import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TTrainerCard extends StatelessWidget {
  final String planName;
  final String trainerName;
  final bool isActive;
  final String? startDate; // Optional start date field
  final String? endDate; // Optional end date field
  final String? profilePic; // New argument for profile picture URL
  final String workouts;
  final String? price; // Optional price field
  final int? duration; // Changed duration to int?

  const TTrainerCard({
    super.key,
    required this.planName,
    required this.trainerName,
    required this.isActive,
    this.startDate, // Accept startDate as an optional parameter
    this.endDate, // Accept endDate as an optional parameter
    this.profilePic, // Accept profilePic as an optional parameter
    required this.workouts, // Workouts field
    this.price, // Optional price field
    this.duration, // Optional duration field
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(TImages.guidanceImage2),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              dark
                  ? Colors.black.withOpacity(0.5)
                  : Colors.transparent.withOpacity(0),
              BlendMode.darken,
            ),
          ),
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.6),
              Colors.transparent,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 4,
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          children: [
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              title: Text(
                planName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.6),
                      offset: const Offset(1, 1),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Trainer: $trainerName',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.6),
                          offset: const Offset(1, 1),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Style: $workouts',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.6),
                          offset: const Offset(1, 1),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (isActive) ...[
                    Text(
                      'Start Date: ${startDate ?? "Not available"}',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.6),
                            offset: const Offset(1, 1),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'End Date: ${endDate ?? "Not available"}',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.6),
                            offset: const Offset(1, 1),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                    ),
                  ] else if (price != null) ...[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 45,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: OutlinedButton(
                              onPressed: () {
                                // Handle join now button press
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: dark ? Colors.white : Colors.white,
                                ),
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                minimumSize: const Size(0, 45),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: FittedBox(
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Join now for ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      TextSpan(
                                        text: '$price Rs/month',
                                        style: const TextStyle(
                                          color: Color(0xFF32CD32),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Duration: ${duration != null ? '$duration months' : "Not available"}',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.6),
                            offset: const Offset(1, 1),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                    ),
                  ] else if (duration != null) ...[
                    Text(
                      'Duration: ${duration != null ? '$duration months' : "Not available"}',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.6),
                            offset: const Offset(1, 1),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
              trailing: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      spreadRadius: 4,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: profilePic != null && profilePic!.isNotEmpty
                      ? Image.network(
                          profilePic!,
                          height: 70,
                          width: 65,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          TImages.homeimage2,
                          height: 70,
                          width: 65,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
