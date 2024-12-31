import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/image_strings.dart';

class UserMembershipCard extends StatelessWidget {
  final String name;
  final String mobile;
  final String planExpiry;
  final String email;
  final String membershipId; // New field for membershipId
  final String profilePic; // New field for profilePic

  const UserMembershipCard({
    Key? key,
    required this.name,
    required this.mobile,
    required this.planExpiry,
    required this.email,
    required this.membershipId, // Added membershipId to constructor
    required this.profilePic, // Added profilePic to constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.network(
                // Use Image.network to load the profile picture
                profilePic.isNotEmpty
                    ? profilePic
                    : profilePic, // Use the provided profilePic or a default one
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
                    style: Theme.of(context).textTheme.headlineMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Mobile: $mobile',
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Plan Expiry: $planExpiry',
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Email: $email',
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Membership ID: $membershipId', // Display membershipId
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
