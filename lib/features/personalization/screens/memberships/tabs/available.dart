import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/card/trainer_membership_card.dart';
import 'package:t_store/common/widgets/searchbars/search_bar.dart';
import 'package:t_store/features/authentication/models/memberships/active_memberships_model.dart';
import 'package:t_store/utils/constants/image_strings.dart';

class AvailableMembershipsScreen extends StatelessWidget {
  const AvailableMembershipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 80, // Define a height for the search bar
              child: TSearchBar(),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final membership = sampleMemberships[index];
                return TTrainerCard(
                  membership: membership,
                );
              },
              childCount: sampleMemberships.length,
            ),
          ),
        ],
      ),
    );
  }
}

List<ActiveMembership> sampleMemberships = [
  ActiveMembership(
    membershipName: 'Fitspo \ngym',
    trainerName: 'Abi',
    styleOfTraining: 'Weight Training',
    trainerImageUrl: TImages.user,
    backgroundImageUrl: TImages.browseImage1,
    subscriptionRates: "1000",
  ),
  ActiveMembership(
    membershipName: 'Dalie',
    trainerName: 'Sura',
    styleOfTraining: 'Weight Training',
    trainerImageUrl: TImages.user,
    backgroundImageUrl: TImages.browseImage2,
    subscriptionRates: "1000",
  ),
  ActiveMembership(
    membershipName: 'Online \nCalisthenics',
    trainerName: 'John Doe',
    styleOfTraining: 'Calisthenics',
    trainerImageUrl: "assets/images/content/ahmed.jpg",
    backgroundImageUrl: TImages.guidanceImage1,
    subscriptionRates: "2000",
  ),
  ActiveMembership(
    membershipName: 'Fitness \nFactory',
    trainerName: 'Jane Smith',
    styleOfTraining: 'Weight Training',
    trainerImageUrl: "assets/images/content/snake.jpg",
    backgroundImageUrl: TImages.guidanceImage2,
    subscriptionRates: "1000",
  ),
  ActiveMembership(
    membershipName: 'Body \nFitness',
    trainerName: 'Rishad',
    styleOfTraining: 'Weight Training',
    trainerImageUrl: TImages.user,
    backgroundImageUrl: TImages.guidanceImage3,
    subscriptionRates: "1500",
  ),
];
