import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/card/trainer_membership_card.dart';
import 'package:t_store/trainer_module/features/controllers/membership_controller.dart';
import 'package:t_store/common/widgets/searchbars/search_bar.dart';
import 'package:t_store/trainer_module/features/controllers/trainer_controller.dart';
import 'package:t_store/trainer_module/features/models/trainer_model.dart';
import 'package:t_store/user_module/features/personalization/screens/memberships/tabs/available/available_membership_details_screen.dart';

class AvailableMembershipsScreen extends StatelessWidget {
  AvailableMembershipsScreen({super.key});

  final MembershipController membershipController =
      Get.put(MembershipController());
  final RxList<Map<String, dynamic>> membershipsWithTrainerDetails =
      <Map<String, dynamic>>[].obs;

  Future<void> fetchMembershipsAndTrainers() async {
    // Fetch memberships
    await membershipController.fetchAvailableMemberships();

    // Fetch trainer details for each unique trainerId
    final trainerIds = membershipController.availableMemberships
        .map((membership) => membership.trainerId)
        .toSet();

    final trainerDetailsMap = <String, TrainerDetails>{};
    for (final trainerId in trainerIds) {
      try {
        final trainerDetailsController = Get.put(
          TrainerDetailsController(),
          tag: trainerId,
        );
        await trainerDetailsController.fetchTrainerDetails(trainerId);
        trainerDetailsMap[trainerId] = trainerDetailsController.trainer.value!;
      } catch (e) {
        print('Failed to fetch trainer details for trainerId $trainerId: $e');
      }
    }

    // Combine memberships and trainer details into a single list
    membershipsWithTrainerDetails.assignAll(
      membershipController.availableMemberships.map((membership) {
        return {
          'membership': membership,
          'trainer': trainerDetailsMap[membership.trainerId],
        };
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Trigger data fetching on screen load
    fetchMembershipsAndTrainers();

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
              // Handle loading state
              if (membershipController.profileLoading.value ||
                  membershipsWithTrainerDetails.isEmpty) {
                return const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              // Handle empty state
              if (membershipsWithTrainerDetails.isEmpty) {
                return const Expanded(
                  child: Center(child: Text('No available memberships.')),
                );
              }

              // Render memberships with trainer details
              return Expanded(
                child: ListView.builder(
                  itemCount: membershipsWithTrainerDetails.length,
                  itemBuilder: (context, index) {
                    final item = membershipsWithTrainerDetails[index];
                    final membership = item['membership'];
                    final trainer = item['trainer'];

                    if (trainer == null) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Center(
                            child: Text('Trainer details not available.')),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: GestureDetector(
                        onTap: () => Get.to(
                          AvailableMembershipDetailsScreen(
                            membership: membership,
                            trainerDetails: trainer,
                          ),
                        ),
                        child: TTrainerCard(
                          profilePic: trainer.profilePic ??
                              'default_profile_pic_url', // Default URL for profile picture
                          isActive: false, // Available memberships are inactive
                          trainerName: trainer.name ?? 'Unknown Trainer',
                          planName: membership.planName,
                          workouts: membership.workouts.join(', '),
                          duration: membership.duration,
                          price: membership.price.toString(),
                        ),
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
