import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:t_store/common/widgets/card/trainer_membership_card.dart';
import 'package:t_store/user_module/features/authentication/models/memberships/active_memberships_model.dart';
import 'package:t_store/user_module/features/personalization/screens/memberships/tabs/active/membership_training_screen.dart';
import 'package:t_store/utils/constants/image_strings.dart';

class ActiveMembershipsScreen extends StatelessWidget {
  const ActiveMembershipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: sampleMemberships.length,
        itemBuilder: (context, index) {
          final membership = sampleMemberships[index];
          return GestureDetector(
            onTap: () {
              // Navigate to the desired screen using Get.to
              Get.to(() => MembershipDetailScreen(membership: membership));
            },
            child: TTrainerCard(
              membership: membership,
            ),
          ); // Use TTrainerCard here
        },
      ),
    );
  }
}

List<ActiveMembership> sampleMemberships = [
  ActiveMembership(
    membershipName: 'Online \nCalisthenics',
    trainerName: 'John Doe',
    styleOfTraining: 'Calisthenics',
    trainerImageUrl: "assets/images/content/ahmed.jpg",
    backgroundImageUrl: TImages.guidanceImage1,
    membershipDuration: '3 days', // Optional
    startDate: DateTime.parse("2024-11-01"), // Required
    endDate: DateTime.parse("2024-11-04"), // Required
  ),
  ActiveMembership(
    membershipName: 'Fitness \nFactory',
    trainerName: 'Jane Smith',
    styleOfTraining: 'Weight Training',
    trainerImageUrl: "assets/images/content/snake.jpg",
    backgroundImageUrl: TImages.guidanceImage2,
    membershipDuration: "25 days", // Optional
    startDate: DateTime.parse("2024-10-01"), // Required
    endDate: DateTime.parse("2024-10-26"), // Required
  ),
];
