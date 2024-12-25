import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/common/widgets/card/trainer_membership_card.dart';
import 'package:t_store/user_module/features/authentication/models/memberships/active_memberships_model.dart';
import 'package:t_store/user_module/features/personalization/screens/memberships/tabs/active/membership_training_screen.dart';

class ActiveMembershipsScreen extends StatelessWidget {
  const ActiveMembershipsScreen({super.key});

  // Fetch Trainer Name using Trainer ID
  Future<Map<String, String>> _getTrainersNames(List<String> trainerIds) async {
    try {
      final trainerDocs = await FirebaseFirestore.instance
          .collection('Profiles') // Reference to 'Profiles' collection
          .where(FieldPath.documentId, whereIn: trainerIds) // Use trainer IDs
          .get();

      Map<String, String> trainerNames = {};
      for (var doc in trainerDocs.docs) {
        // Fetching the 'firstName' and 'lastName' fields
        final firstName = doc.data()?['firstName'] ?? '';
        final lastName = doc.data()?['lastName'] ?? '';
        trainerNames[doc.id] = '$firstName $lastName'.trim(); // Combine names
      }
      return trainerNames;
    } catch (e) {
      // Handle errors and return an empty map in case of failure
      return {};
    }
  }

  Future<List<ActiveMembership>> _getActiveMemberships() async {
    try {
      final membershipQuery = FirebaseFirestore.instance
          .collection('memberships')
          .where('available', isEqualTo: true);

      final querySnapshot = await membershipQuery.get();
      final memberships = querySnapshot.docs.map((doc) {
        final data = doc.data();

        return ActiveMembership(
          membershipName: data['name'] ?? 'No Name',
          trainerId:
              data['trainerId'] ?? '', // Assuming trainerId is stored here
          styleOfTraining: data['styleOfTraining'] ?? 'Unknown Training',
          trainerImageUrl: data['trainerImageUrl'] ?? '',
          backgroundImageUrl: data['backgroundImageUrl'] ?? '',
          membershipDuration: data['duration'] ?? '0 days',
          startDate: data['startDate'] != null
              ? DateTime.parse(data['startDate'])
              : DateTime.now(),
          endDate: data['endDate'] != null
              ? DateTime.parse(data['endDate'])
              : DateTime.now(),
          trainerName: '',
        );
      }).toList();

      return memberships;
    } catch (e) {
      throw Exception("Error fetching active memberships: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Active Memberships')),
      body: FutureBuilder<List<ActiveMembership>>(
        future: _getActiveMemberships(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text('No active memberships available.'));
          }

          final memberships = snapshot.data!;

          // Extract trainer IDs
          final trainerIds = memberships
              .map((membership) => membership.trainerId)
              .toSet()
              .toList();

          // Fetch trainer names
          return FutureBuilder<Map<String, String>>(
            future: _getTrainersNames(trainerIds),
            builder: (context, trainerSnapshot) {
              if (trainerSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (trainerSnapshot.hasError) {
                return Center(child: Text('Error: ${trainerSnapshot.error}'));
              }

              final trainerNames = trainerSnapshot.data ?? {};

              return ListView.builder(
                itemCount: memberships.length,
                itemBuilder: (context, index) {
                  final membership = memberships[index];
                  final trainerName = trainerNames[membership.trainerId] ??
                      'Unknown Trainer'; // Get the trainer name

                  return GestureDetector(
                    onTap: () {
                      // Navigate to the desired screen using Get.to
                      Get.to(
                          () => MembershipDetailScreen(membership: membership));
                    },
                    child: TTrainerCard(
                      trainerName: trainerName, // Pass the fetched trainer name
                      membership: membership,
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
