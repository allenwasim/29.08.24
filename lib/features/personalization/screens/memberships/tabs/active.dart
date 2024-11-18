import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/card/trainer_membership_card.dart';
import 'package:t_store/features/authentication/models/memberships/active_memberships_model.dart';
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
          return TTrainerCard(
            membership: membership,
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
      membershipDuration: '3 days'),
  ActiveMembership(
      membershipName: 'Fitness \nFactory',
      trainerName: 'Jane Smith',
      styleOfTraining: 'Weight Training',
      trainerImageUrl: "assets/images/content/snake.jpg",
      backgroundImageUrl: TImages.guidanceImage2,
      membershipDuration: "25 days"),
];
