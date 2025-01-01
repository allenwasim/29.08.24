import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/card/trainer_membership_card.dart';
import 'package:t_store/trainer_module/features/controllers/membership_controller.dart';
import 'package:t_store/common/widgets/searchbars/search_bar.dart';
import 'package:t_store/trainer_module/features/controllers/trainer_controller.dart';
import 'package:t_store/user_module/features/personalization/controllers/user_controller.dart';
import 'package:t_store/user_module/features/personalization/screens/memberships/tabs/active/membership_training_screen.dart';

class ActiveMembershipsScreen extends StatelessWidget {
  ActiveMembershipsScreen({super.key});

  final MembershipController membershipController =
      Get.put(MembershipController());
  final TrainerDetailsController trainerDetailsController =
      Get.put(TrainerDetailsController());

  @override
  Widget build(BuildContext context) {
    // Triggering data fetch on screen load
    final String userId = UserController.instance.user.value.id;
    membershipController
        .findMembershipsByClientId(userId); // Fetch memberships by clientId

    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Memberships'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          const TSearchBar(),
          Obx(
            () {
              // Handle loading state for fetching memberships
              if (membershipController.isLoading.value) {
                return const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              // Handle empty state when no memberships are found
              if (membershipController.clientMemberships.isEmpty) {
                return const Expanded(
                  child: Center(child: Text('No active memberships.')),
                );
              }

              // List of active memberships
              return Expanded(
                child: ListView.builder(
                  itemCount: membershipController.clientMemberships.length,
                  itemBuilder: (context, index) {
                    final membership =
                        membershipController.clientMemberships[index];

                    // Fetch trainer details based on trainerId from membership
                    trainerDetailsController.fetchTrainerDetails(
                        membershipController.user.value.trainerId);

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Obx(
                        () {
                          // Wait until trainer details are fetched
                          if (trainerDetailsController.profileLoading.value) {
                            return const CircularProgressIndicator();
                          }

                          return GestureDetector(
                            onTap: () => Get.to(
                              MembershipDetailScreen(
                                membership: membership,
                              ),
                            ),
                            child: TTrainerCard(
                              profilePic: trainerDetailsController
                                      .trainer.value?.profilePic ??
                                  'default_profile_pic_url',
                              isActive: true, // Active memberships are active
                              trainerName: trainerDetailsController
                                      .trainer.value?.name ??
                                  'Unknown Trainer',
                              startDate: membershipController
                                  .user.value.createdAt
                                  .toString(),
                              endDate: membershipController.user.value.endDate
                                      ?.toString() ??
                                  'No end date',
                              planName:
                                  membershipController.user.value.planName,
                              workouts: membershipController.user.value.workouts
                                  .join(', '),
                              duration:
                                  membershipController.user.value.duration,
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
