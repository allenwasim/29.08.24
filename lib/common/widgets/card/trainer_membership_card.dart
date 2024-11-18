import 'package:flutter/material.dart';
import 'package:t_store/features/authentication/models/memberships/active_memberships_model.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';
// Import dart:ui for the blur effect

class TTrainerCard extends StatelessWidget {
  final ActiveMembership membership;

  const TTrainerCard({
    super.key,
    required this.membership,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: AssetImage(membership.backgroundImageUrl),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              dark
                  ? Colors.black.withOpacity(.3)
                  : Colors.transparent.withOpacity(0),
              BlendMode.darken,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              title: Text(
                membership.membershipName,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.6),
                      offset: const Offset(1, 1),
                      blurRadius: 3,
                    ),
                  ],
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Trainer: ${membership.trainerName}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
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
                    'Style: ${membership.styleOfTraining}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.6),
                          offset: const Offset(1, 1),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8), // Add spacing
                  if (membership.subscriptionRates != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 40,
                          width: 200, // Adjusted width for button text
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
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
                                      horizontal: 8.0), // Adjust padding
                                  minimumSize:
                                      const Size(200, 40), // Set minimum size
                                ),
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Join now for ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      TextSpan(
                                        text:
                                            '${membership.subscriptionRates} Rs/month',
                                        style: const TextStyle(
                                          color: Color(0xFF32CD32),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ],
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                )),
                          ),
                        ),
                      ],
                    ),
                  if (membership.membershipDuration != null)
                    Text(
                      'Time Left: ${membership.membershipDuration}',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
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
              ),
              trailing: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      spreadRadius: 4,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    membership.trainerImageUrl,
                    height: 60,
                    width: 55,
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
