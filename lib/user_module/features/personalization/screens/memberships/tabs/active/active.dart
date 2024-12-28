import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/common/widgets/card/trainer_membership_card.dart';
import 'package:t_store/trainer_module/data/repositories/trainer_repository.dart';
import 'package:t_store/trainer_module/features/models/membership_model.dart';
import 'package:t_store/user_module/data/repositories/user/user_repositries.dart';
import 'package:t_store/user_module/features/personalization/screens/memberships/tabs/active/membership_training_screen.dart';
import 'package:t_store/common/widgets/searchbars/search_bar.dart';
import 'package:t_store/trainer_module/features/models/trainer_model.dart';

class ActiveMembershipsScreen extends StatelessWidget {
  ActiveMembershipsScreen({super.key});

  final TrainerRepository _trainerRepository = TrainerRepository();
  final UserRepository userRepository = Get.put(UserRepository());

  Future<List<String>> _getClientMembershipIds(String clientId) async {
    try {
      final clientDoc = await FirebaseFirestore.instance
          .collection('Profiles')
          .doc(clientId)
          .collection('clientDetails')
          .doc('details')
          .get();

      final clientData = clientDoc.data();
      if (clientData != null) {
        final memberships = clientData['memberships'];
        if (memberships != null && memberships is List) {
          return memberships.map<String>((membership) {
            return membership['membershipId'] ?? '';
          }).toList();
        }
      }
      return [];
    } catch (e) {
      print('Error fetching client memberships: $e');
      throw Exception("Error fetching client memberships: $e");
    }
  }

  Future<List<MembershipModel>> _getFilteredActiveMemberships(
      List<String> clientMembershipIds) async {
    try {
      final membershipQuery = FirebaseFirestore.instance
          .collection('memberships')
          .where('membershipId', whereIn: clientMembershipIds);

      final querySnapshot = await membershipQuery.get();
      final memberships = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return MembershipModel(
          id: doc.id,
          membershipId: data['membershipId'] ?? '',
          trainerId: data['trainerId'] ?? '',
          planName: data['name'] ?? 'No Name',
          description: data['description'] ?? '',
          price: data['price'] ?? 0.0,
          duration: data['duration'] ?? '0 days',
          workouts: List<String>.from(data['workouts'] ?? []),
          isAvailable: data['isAvailable'] ?? true,
          createdAt:
              (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
          startDate: data['startDate'] != null
              ? DateTime.parse(data['startDate'])
              : null,
          endDate:
              data['endDate'] != null ? DateTime.parse(data['endDate']) : null,
        );
      }).toList();
      return memberships;
    } catch (e) {
      throw Exception("Error fetching filtered active memberships: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String>(
        future: _getCurrentUserId(),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (userSnapshot.hasError || !userSnapshot.hasData) {
            return const Center(child: Text('Error fetching user data.'));
          }

          final clientId = userSnapshot.data!;

          return FutureBuilder<List<String>>(
            future: _getClientMembershipIds(clientId),
            builder: (context, membershipIdsSnapshot) {
              if (membershipIdsSnapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (membershipIdsSnapshot.hasError) {
                return Center(
                    child: Text('Error: ${membershipIdsSnapshot.error}'));
              }

              final clientMembershipIds = membershipIdsSnapshot.data ?? [];

              return FutureBuilder<List<MembershipModel>>(
                future: _getFilteredActiveMemberships(clientMembershipIds),
                builder: (context, membershipsSnapshot) {
                  if (membershipsSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (membershipsSnapshot.hasError) {
                    return Center(
                        child: Text('Error: ${membershipsSnapshot.error}'));
                  }

                  final memberships = membershipsSnapshot.data ?? [];

                  if (memberships.isEmpty) {
                    return const Center(
                        child: Text('No active memberships available.'));
                  }

                  final trainerIds = memberships
                      .map((membership) => membership.trainerId)
                      .toSet()
                      .toList();

                  return FutureBuilder<Map<String, String>>(
                    future: _getTrainersNames(trainerIds),
                    builder: (context, trainerSnapshot) {
                      if (trainerSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (trainerSnapshot.hasError) {
                        return Center(
                            child: Text('Error: ${trainerSnapshot.error}'));
                      }

                      final trainerNames = trainerSnapshot.data ?? {};

                      return CustomScrollView(
                        slivers: [
                          const SliverToBoxAdapter(
                            child: SizedBox(
                              height: 80,
                              child: TSearchBar(),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Active Memberships',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ),
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final membership = memberships[index];
                                final trainerName =
                                    trainerNames[membership.trainerId] ??
                                        'Unknown Trainer';

                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(() => MembershipDetailScreen(
                                          membership: membership));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: TTrainerCard(
                                        isActive: true,
                                        trainerName: trainerName,
                                        membership: membership,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              childCount: memberships.length,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Future<String> _getCurrentUserId() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      return currentUser.uid;
    } else {
      throw Exception('No user is currently logged in');
    }
  }

  Future<Map<String, String>> _getTrainersNames(List<String> trainerIds) async {
    final Map<String, String> trainerNames = {};
    for (final trainerId in trainerIds) {
      final trainerDetails =
          await userRepository.fetchTrainerDetails(trainerId);
      if (trainerDetails != null) {
        trainerNames[trainerId] = trainerDetails['name'] ?? 'Unknown Trainer';
      }
    }
    return trainerNames;
  }
}
