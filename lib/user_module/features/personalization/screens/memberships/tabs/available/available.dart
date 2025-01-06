import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/card/trainer_membership_card.dart';
import 'package:t_store/trainer_module/features/controllers/membership_controller.dart';
import 'package:t_store/common/widgets/searchbars/search_bar.dart';
import 'package:t_store/trainer_module/features/controllers/trainer_controller.dart';
import 'package:t_store/user_module/features/personalization/screens/memberships/tabs/available/available_membership_details_screen.dart';

class AvailableMembershipsScreen extends StatelessWidget {
  AvailableMembershipsScreen({super.key});

  final MembershipController membershipController =
      Get.put(MembershipController());
  final TrainerDetailsController trainerDetailsController =
      Get.put(TrainerDetailsController());

  @override
  Widget build(BuildContext context) {
    // Triggering data fetch on screen load
    membershipController.fetchAvailableMemberships();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Memberships'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          const TSearchBar(),
          Obx(
            () {
              // Handle loading state for memberships
              if (membershipController.profileLoading.value) {
                return const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              // Handle empty state
              if (membershipController.availableMemberships.isEmpty) {
                return const Expanded(
                  child: Center(child: Text('No available memberships.')),
                );
              }

              // List of available memberships
              return Expanded(
                child: ListView.builder(
                  itemCount: membershipController.availableMemberships.length,
                  itemBuilder: (context, index) {
                    final membership =
                        membershipController.availableMemberships[index];

                    // Fetch trainer details based on trainerId from membership
                    trainerDetailsController
                        .fetchTrainerDetails(membership.trainerId);

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Obx(
                        () {
                          // Wait until trainer details are fetched
                          if (trainerDetailsController.profileLoading.value) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          // Ensure the trainer data is available before rendering the card
                          final trainer =
                              trainerDetailsController.trainer.value;
                          if (trainer == null) {
                            return const Center(
                                child: Text('Trainer details not available.'));
                          }

                          return GestureDetector(
                            onTap: () =>
                                Get.to(AvailableMembershipDetailsScreen(
                              membership: membership,
                              trainerDetails: trainer,
                            )),
                            child: TTrainerCard(
                              profilePic: trainer.profilePic ??
                                  'default_profile_pic_url', // Default URL for profile picture
                              isActive:
                                  false, // Available memberships are inactive
                              trainerName: trainer.name ?? 'Unknown Trainer',
                              planName: membership.planName,
                              workouts: membership.workouts.join(', '),
                              duration: membership.duration,
                              price: membership.price.toString(),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
