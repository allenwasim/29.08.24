import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/card/trainer_membership_card.dart';
import 'package:t_store/common/widgets/searchbars/search_bar.dart';
import 'package:t_store/trainer_module/data/repositories/trainer_repository.dart';
import 'package:t_store/user_module/features/authentication/models/memberships/active_memberships_model.dart';
import 'package:t_store/user_module/features/personalization/screens/memberships/tabs/active/membership_training_screen.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/trainer_module/features/models/trainer_model.dart';

class AvailableMembershipsScreen extends StatelessWidget {
  AvailableMembershipsScreen({super.key});

  final TrainerRepository trainerRepository = TrainerRepository();

  Future<List<ActiveMembership>> _getAvailableMemberships() async {
    try {
      final membershipQuery = FirebaseFirestore.instance
          .collection('memberships')
          .where('available', isEqualTo: true);

      final querySnapshot = await membershipQuery.get();

      final memberships = await Future.wait(querySnapshot.docs.map((doc) async {
        final data = doc.data();
        if (data == null) {
          return ActiveMembership(
            trainerId: '',
            membershipName: 'No Name',
            trainerName: 'Unknown Trainer',
            styleOfTraining: 'Unknown Training',
            trainerImageUrl: '',
            backgroundImageUrl: '',
            subscriptionRates: '0.0',
            startDate: DateTime.now(),
            endDate: DateTime.now(),
          );
        }

        String trainerName = 'Unknown Trainer';
        String trainerImageUrl = '';
        String trainerId = '';
        String styleOfTraining = 'Unknown Training';

        // Fetch trainer details from Profiles collection
        if (data.containsKey('trainerId') && data['trainerId'] is String) {
          trainerId = data['trainerId'];
          try {
            final trainerDoc = await FirebaseFirestore.instance
                .collection('Profiles')
                .doc(trainerId)
                .get();

            if (trainerDoc.exists) {
              final trainerData = trainerDoc.data();
              if (trainerData != null) {
                trainerName = trainerData['firstName'] ?? 'Unknown Trainer';
                trainerImageUrl = trainerData['profilePicture'] ?? '';
              }
            }
          } catch (e) {
            debugPrint("Error fetching trainer details: $e");
          }
        }

        // Get workouts and include them in the style of training
        if (data.containsKey('workouts') && data['workouts'] is List) {
          final workouts = List<String>.from(data['workouts']);
          styleOfTraining = workouts.join(', ');
        }

        return ActiveMembership(
          trainerId: trainerId,
          membershipName: data['name'] ?? 'No Name',
          trainerName: trainerName,
          styleOfTraining: styleOfTraining,
          trainerImageUrl: trainerImageUrl,
          backgroundImageUrl: data['backgroundImageUrl'] ?? '',
          subscriptionRates: data['price']?.toString() ?? '0.0',
          startDate:
              (data['startDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
          endDate: (data['endDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
        );
      }).toList());

      return memberships;
    } catch (e) {
      debugPrint("Error fetching memberships: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ActiveMembership>>(
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
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final membership = memberships[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to the MembershipDetailScreen
                          Get.to(() =>
                              MembershipDetailScreen(membership: membership));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TTrainerCard(
                            membership: membership,
                            trainerName: membership
                                .trainerName, // Pass the trainerName to TTrainerCard
                          ),
                        ),
                      ),
                    );
                  },
                  childCount:
                      memberships.length, // Set the childCount dynamically
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
