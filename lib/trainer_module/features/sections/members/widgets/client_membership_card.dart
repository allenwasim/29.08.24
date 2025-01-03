import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/utils/helpers/helper_functions.dart'; // Import TColors

class UserMembershipCard extends StatelessWidget {
  final String name;
  final String mobile;
  final String planExpiry;
  final String email;
  final String membershipId;
  final String profilePic;
  final String daysLeft;

  const UserMembershipCard({
    Key? key,
    required this.name,
    required this.mobile,
    required this.planExpiry,
    required this.email,
    required this.membershipId,
    required this.profilePic,
    required this.daysLeft, // Added daysLeft
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // If daysLeft is not passed, calculate it from the planExpiry
    String remainingDays = daysLeft;

    if (remainingDays.isEmpty) {
      final expiryDate = DateTime.tryParse(planExpiry);
      if (expiryDate != null) {
        final difference = expiryDate.difference(DateTime.now()).inDays;
        remainingDays = difference > 0 ? '$difference days left' : 'Expired';
      } else {
        remainingDays = 'Invalid Date';
      }
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: isDarkMode
          ? TColors.black
          : const Color.fromARGB(
              255, 249, 254, 244), // Change background color for dark mode
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.network(
                profilePic,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: 14,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  _buildDetailText('Mobile', mobile, isDarkMode),
                  const SizedBox(height: 5),
                  _buildDetailText('Plan Expiry', planExpiry, isDarkMode),
                  const SizedBox(height: 5),
                  _buildDetailText('Email', email, isDarkMode),
                  const SizedBox(height: 5),
                  _buildDetailText('Membership ID', membershipId, isDarkMode),
                  const SizedBox(height: 5),
                  _buildDetailText('Days Left', remainingDays,
                      isDarkMode), // Displaying the Days Left
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailText(String title, String value, bool isDarkMode) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$title: ',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? TColors.primary : TColors.trainerPrimary,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              fontSize: 12,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
