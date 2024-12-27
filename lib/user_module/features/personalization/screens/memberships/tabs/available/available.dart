import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/card/trainer_membership_card.dart';
import 'package:t_store/common/widgets/searchbars/search_bar.dart';
import 'package:t_store/trainer_module/data/repositories/trainer_repository.dart';
import 'package:t_store/trainer_module/features/models/membership_model.dart';
import 'package:t_store/trainer_module/features/models/trainer_model.dart';
import 'package:t_store/user_module/features/personalization/screens/memberships/tabs/available/available_membership_details_screen.dart';

class AvailableMembershipsScreen extends StatelessWidget {
  AvailableMembershipsScreen({super.key});

  final TrainerRepository trainerRepository = TrainerRepository();

  // Fetch available memberships using the repository
  Future<List<MembershipModel>> _getAvailableMemberships() async {
    return await trainerRepository
        .getAvailableMemberships(); // Ensure this method returns MembershipModel instances
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<MembershipModel>>(
        future: _getAvailableMemberships(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No available memberships.'));
          }

          final memberships = snapshot.data!;

          return CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 80, // Define a height for the search bar
                  child: TSearchBar(),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Available Memberships',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final membership = memberships[index];

                    // Fetch trainer details using the trainerId
                    return FutureBuilder<TrainerDetails?>(
                      future: trainerRepository
                          .getTrainerDetails(membership.trainerId),
                      builder: (context, trainerSnapshot) {
                        if (trainerSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (trainerSnapshot.hasError) {
                          return Center(
                              child: Text('Error: ${trainerSnapshot.error}'));
                        }

                        final trainerDetails = trainerSnapshot.data;
                        final trainerName =
                            trainerDetails?.name ?? 'Unknown Trainer';

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              // Navigate to MembershipDetailsScreen with the full membership object
                              Get.to(() => AvailableMembershipDetailsScreen(
                                    membership:
                                        membership, // Pass the entire membership object
                                  ));
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: TTrainerCard(
                                membership: membership,
                                trainerName:
                                    trainerName, // Pass the trainer's name here
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  childCount: memberships.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
