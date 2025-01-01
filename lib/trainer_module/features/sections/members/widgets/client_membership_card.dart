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

  const UserMembershipCard({
    Key? key,
    required this.name,
    required this.mobile,
    required this.planExpiry,
    required this.email,
    required this.membershipId,
    required this.profilePic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if dark mode is enabled
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
                profilePic.isNotEmpty ? profilePic : TImages.userProfileImage1,
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
                          fontSize: 14, // Make the name smaller
                          color: isDarkMode
                              ? Colors.white
                              : Colors.black, // Adjust text color for dark mode
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
              fontSize: 12, // Smaller text
              fontWeight: FontWeight.bold,
              color: isDarkMode
                  ? TColors.primary
                  : TColors.trainerPrimary, // Apply dark mode compatible color
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              fontSize: 12, // Smaller text
              color: isDarkMode
                  ? Colors.white
                  : Colors.black, // Adjust text color for dark mode
            ),
          ),
        ],
      ),
    );
  }
}
