import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/common/widgets/card/trainer_membership_card.dart';
import 'package:t_store/trainer_module/features/models/membership_model.dart';
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
        final firstName = doc.data()?['firstName'] ?? '';
        final lastName = doc.data()?['lastName'] ?? '';
        trainerNames[doc.id] = '$firstName $lastName'.trim(); // Combine names
      }
      return trainerNames;
    } catch (e) {
      return {};
    }
  }

  // Fetch active memberships
  Future<List<MembershipModel>> _getActiveMemberships() async {
    try {
      final membershipQuery = FirebaseFirestore.instance
          .collection('memberships')
          .where('available', isEqualTo: true);

      final querySnapshot = await membershipQuery.get();
      final memberships = querySnapshot.docs.map((doc) {
        final data = doc.data();

        // Mapping to MembershipModel
        return MembershipModel(
          id: doc.id,
          membershipId: data['membershipId'] ??
              '', // You need to ensure 'membershipId' is included
          trainerId: data['trainerId'] ?? '',
          planName: data['name'] ?? 'No Name',
          description: data['description'] ??
              '', // Provide description (use empty string if not present)
          price: data['price'] ??
              0.0, // Initialize with default price if not available
          duration: data['duration'] ?? '0 days',
          workouts: List<String>.from(data['workouts'] ??
              []), // Default to an empty list if no workouts
          isAvailable: data['isAvailable'] ??
              true, // Assuming it's a boolean in Firestore
          createdAt: (data['createdAt'] as Timestamp?)?.toDate() ??
              DateTime.now(), // Default to current time if null
          startDate: data['startDate'] != null
              ? DateTime.parse(data['startDate'])
              : null, // Nullable startDate
          endDate: data['endDate'] != null
              ? DateTime.parse(data['endDate'])
              : null, // Nullable endDate
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
      body: FutureBuilder<List<MembershipModel>>(
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
                      // Navigate to the MembershipDetailsScreen with the membership model
                      Get.to(
                          () => MembershipDetailScreen(membership: membership));
                    },
                    child: TTrainerCard(
                      trainerName: trainerName, // Pass the fetched trainer name
                      membership:
                          membership, // Pass the full MembershipModel object
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
