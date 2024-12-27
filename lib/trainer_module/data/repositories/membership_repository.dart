import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:t_store/trainer_module/features/models/membership_model.dart';

class MembershipRepository extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to add a membership plan and save it to Firestore
  Future<MembershipModel> addMembershipPlan(
    String trainerId,
    String name,
    String description,
    double price,
    String duration,
    List<String> workouts,
    bool isAvailable,
  ) async {
    try {
      // Generate a unique membershipId
      String membershipId = _firestore.collection('memberships').doc().id;

      // Prepare the membership plan data
      Map<String, dynamic> membershipData = {
        'membershipId': membershipId, // Add unique membershipId
        'trainerId': trainerId,
        'planName': name,
        'description': description,
        'price': price,
        'duration': duration,
        'workouts': workouts,
        'isAvailable': isAvailable,
        'createdAt':
            FieldValue.serverTimestamp(), // Save the timestamp of creation
      };

      // Add the membership plan to the Firestore collection "memberships"
// Get the DocumentReference for the generated membershipId
      DocumentReference ref =
          _firestore.collection('memberships').doc(membershipId);

// Use the `set` method to save the data
      await ref.set(membershipData);

      // After the document is added, create the MembershipModel object
      MembershipModel membership = MembershipModel(
        id: membershipId, // Use the generated membershipId
        membershipId: membershipId,
        trainerId: trainerId,
        planName: name,
        description: description,
        price: price,
        duration: duration,
        workouts: workouts,
        isAvailable: isAvailable,
        createdAt: DateTime.now(),
      );

      print(
          'Membership Plan added for Trainer ID: $trainerId with Membership ID: $membershipId');
      return membership; // Return the created MembershipModel object
    } catch (e) {
      print('Error adding membership plan: $e');
      throw Exception('Failed to add membership plan');
    }
  }

  // Function to fetch membership plan details using the membership ID
  Future<Map<String, dynamic>> fetchMembershipPlan(String membershipId) async {
    try {
      // Fetch the membership plan from Firestore using the membership ID
      DocumentSnapshot snapshot =
          await _firestore.collection('memberships').doc(membershipId).get();

      if (snapshot.exists) {
        // If the document exists, return the data as a Map
        return snapshot.data() as Map<String, dynamic>;
      } else {
        throw Exception('Membership plan not found for ID: $membershipId');
      }
    } catch (e) {
      print('Error fetching membership plan: $e');
      throw Exception('Failed to fetch membership plan');
    }
  }

  // Function to fetch membership plan details using the trainer ID
  Future<List<Map<String, dynamic>>> fetchMembershipPlansByTrainer(
      String trainerId) async {
    try {
      // Fetch the membership plans for the given trainerId from Firestore
      QuerySnapshot snapshot = await _firestore
          .collection('memberships')
          .where('trainerId', isEqualTo: trainerId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        // If there are matching documents, return all as a list of Maps
        return snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      } else {
        throw Exception('No membership plans found for Trainer ID: $trainerId');
      }
    } catch (e) {
      print('Error fetching membership plans: $e');
      throw Exception('Failed to fetch membership plans');
    }
  }
}
