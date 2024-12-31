import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:t_store/trainer_module/features/models/membership_model.dart';
import 'package:t_store/utils/constants/image_strings.dart';

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
      String membershipId = _firestore.collection('memberships').doc().id;

      Map<String, dynamic> membershipData = {
        'membershipId': membershipId,
        'trainerId': trainerId,
        'planName': name,
        'description': description,
        'price': price,
        'duration': duration,
        'workouts': workouts,
        'isAvailable': isAvailable,
        'createdAt': FieldValue.serverTimestamp(),
      };

      DocumentReference ref =
          _firestore.collection('memberships').doc(membershipId);

      await ref.set(membershipData);

      MembershipModel membership = MembershipModel(
        id: membershipId,
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
      return membership;
    } catch (e) {
      print('Error adding membership plan: $e');
      throw Exception('Failed to add membership plan');
    }
  }

  // Function to fetch membership plan details using the membership ID
  Future<Map<String, dynamic>> fetchMembershipPlan(String membershipId) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('memberships').doc(membershipId).get();

      if (snapshot.exists) {
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
      QuerySnapshot snapshot = await _firestore
          .collection('memberships')
          .where('trainerId', isEqualTo: trainerId)
          .get();

      if (snapshot.docs.isNotEmpty) {
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

  // Function to fetch user memberships from the "ClientDetails" collection
  Future<List<Map<String, dynamic>>> fetchUserMemberships(String userId) async {
    try {
      DocumentSnapshot userDoc = await _firestore
          .collection('Profiles')
          .doc(userId)
          .collection('clientDetails')
          .doc('details')
          .get();

      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        List<Map<String, dynamic>> memberships =
            List<Map<String, dynamic>>.from(userData['memberships'] ?? []);

        print('Fetched memberships for User ID: $userId');
        return memberships;
      } else {
        throw Exception('User not found for ID: $userId');
      }
    } catch (e) {
      print('Error fetching user memberships: $e');
      throw Exception('Failed to fetch user memberships');
    }
  }

  // Function to fetch membership details of all clients for a specific trainer

  // Function to fetch client IDs for a trainer
  Future<List<String>> getClientIds(String trainerId) async {
    try {
      final trainerDoc = await FirebaseFirestore.instance
          .collection('Profiles')
          .doc(trainerId)
          .collection('trainerDetails')
          .doc('details')
          .get();

      final trainerData = trainerDoc.data();
      if (trainerData != null) {
        final memberships = trainerData['members'];
        if (memberships != null && memberships is List) {
          return memberships.map<String>((membership) {
            return membership['clientId'] ?? ''; // Extract client IDs
          }).toList();
        }
      }
      return []; // Return empty list if no memberships are found
    } catch (e) {
      print('Error fetching client IDs: $e');
      throw Exception("Error fetching client IDs: $e");
    }
  }

// Function to fetch membership details for a trainer
  Future<List<Map<String, dynamic>>> getMembershipDetailsForTrainer(
      String trainerId) async {
    try {
      // Fetch client IDs associated with the trainer
      final clientIds = await getClientIds(trainerId);

      List<Map<String, dynamic>> membershipDetails = [];

      // Iterate through each client and fetch their membership details
      for (String clientId in clientIds) {
        final clientDoc = await _firestore
            .collection('Profiles')
            .doc(clientId)
            .collection('clientDetails')
            .doc('details')
            .get();
        final clientData = clientDoc.data();

        if (clientData != null && clientData['memberships'] != null) {
          for (var membership in clientData['memberships']) {
            membershipDetails.add({
              'pic': clientData['profilePic'] ?? TImages.userProfileImage1,
              'name': clientData['name'],
              'email': clientData['email'],
              'mobile': clientData['phoneNumber'],
              'planExpiry': membership['endDate'] != null
                  ? (membership['endDate'] as Timestamp).toDate().toString()
                  : 'Not available',
              'membershipId': membership['membershipId'] ?? 'Not available',
            });
          }
        }
      }

      return membershipDetails;
    } catch (e) {
      print('Error fetching membership details: $e');
      throw Exception("Error fetching membership details: $e");
    }
  }
}
