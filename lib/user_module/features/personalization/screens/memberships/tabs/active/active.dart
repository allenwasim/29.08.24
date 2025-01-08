import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:t_store/common/widgets/card/trainer_membership_card.dart';
import 'package:t_store/trainer_module/features/controllers/membership_controller.dart';
import 'package:t_store/common/widgets/searchbars/search_bar.dart';
import 'package:t_store/trainer_module/features/controllers/trainer_controller.dart';
import 'package:t_store/user_module/features/authentication/controllers/client_details/client_details_controller.dart';
import 'package:t_store/user_module/features/personalization/controllers/user_controller.dart';
import 'package:t_store/user_module/features/personalization/screens/memberships/tabs/active/membership_training_screen.dart';
import 'package:t_store/utils/constants/image_strings.dart';

class ActiveMembershipsScreen extends StatelessWidget {
  ActiveMembershipsScreen({super.key});

  final MembershipController membershipController =
      Get.put(MembershipController());
  final TrainerDetailsController trainerDetailsController =
      Get.put(TrainerDetailsController());
  final ClientDetailsController clientDetailsController =
      Get.put(ClientDetailsController());

  @override
  Widget build(BuildContext context) {
    // Triggering data fetch on screen load
    final String userId = UserController.instance.user.value.id;
    membershipController.findMembershipsByClientId(userId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Memberships'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          const TSearchBar(),
          Obx(() {
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

            // Pre-fetch trainer details only once to avoid unnecessary network calls
            for (var membership in membershipController.clientMemberships) {
              if (!trainerDetailsController.trainerMap
                  .containsKey(membership.trainerId)) {
                trainerDetailsController
                    .fetchTrainerDetails(membership.trainerId);
              }
            }

            // Date format for displaying start and end dates
            final DateFormat dateFormat = DateFormat('dd MMM yyyy');

            return Expanded(
              child: ListView.builder(
                itemCount: membershipController.clientMemberships.length,
                itemBuilder: (context, index) {
                  final membership =
                      membershipController.clientMemberships[index];
                  final trainer = trainerDetailsController.trainerMap[membership
                      .trainerId]; // Use the trainerMap to get trainer details

                  // Fetch client membership details for start and end date
                  clientDetailsController.fetchClientMemberships(
                    clientId: userId,
                    membershipId: membership.membershipId,
                  );

                  // Listen for changes in client membership data
                  return Obx(() {
                    final clientMembership =
                        clientDetailsController.clientMembershipData.value;

                    // Ensure clientMembership data is available
                    if (clientMembership == null) {
                      return const Center(
                          child: Text('Loading membership details...'));
                    }

                    // Extract start and end date from clientMembership
                    final startDate = clientMembership['startDate'] != null
                        ? dateFormat
                            .format(clientMembership['startDate'].toDate())
                        : 'Unknown start date';
                    final endDate = clientMembership['endDate'] != null
                        ? dateFormat
                            .format(clientMembership['endDate'].toDate())
                        : 'No end date';

                    final String trainerName =
                        trainer?.name ?? 'Unknown Trainer';
                    final String trainerProfilePic =
                        trainer?.profilePic ?? TImages.userProfileImage1;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to ActiveMembershipDetailScreen with both membership and trainer details
                          Get.to(
                            ActiveMembershipDetailScreen(
                              membership: membership,
                              trainer: trainer!,
                              clientMembership:
                                  clientMembership, // Safely pass trainer details
                            ),
                          );
                        },
                        child: TTrainerCard(
                          profilePic: trainerProfilePic,
                          isActive: true, // Active memberships are active
                          trainerName: trainerName,
                          startDate: startDate,
                          endDate: endDate,
                          planName: membership.planName,
                          workouts: membership.workouts.join(', '),
                          duration: membership.duration,
                        ),
                      ),
                    );
                  });
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
