import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/trainer_module/features/models/membership_model.dart';
import 'package:t_store/trainer_module/features/models/trainer_model.dart';

class TrainerRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<TrainerDetails?> getTrainerDetails(String trainerId) async {
    try {
      final docSnapshot =
          await _firestore.collection('Profiles').doc(trainerId).get();
      if (docSnapshot.exists) {
        final data = docSnapshot.data()!;
        if (data['role'] == 'trainer') {
          return TrainerDetails.fromJson(data['trainerDetails'] ?? {});
        }
      }
      return null;
    } catch (e) {
      print('Error fetching trainer details: $e');
      return null;
    }
  }

  // Update TrainerDetails in Firestore
  Future<void> updateTrainerDetails(
      String trainerId, TrainerDetails trainerDetails) async {
    try {
      await _firestore.collection('users').doc(trainerId).update({
        'trainerDetails': trainerDetails.toJson(),
      });
    } catch (e) {
      print('Error updating trainer details: $e');
    }
  }

  // Add a new Trainer to Firestore
  Future<void> addTrainer(
      String trainerId, TrainerDetails trainerDetails) async {
    try {
      await _firestore.collection('users').doc(trainerId).set({
        'role': 'trainer',
        'trainerDetails': trainerDetails.toJson(),
      });
    } catch (e) {
      print('Error adding new trainer: $e');
    }
  }

  // Add Membership Plan to Firestore using MembershipModel
  Future<void> addMembershipPlan(
    String trainerId,
    String planName,
    String description,
    double price,
    String duration,
    List<String> workouts,
    bool isAvailable,
  ) async {
    try {
      final membership = MembershipModel(
        id: '', // Firebase will generate ID
        membershipId: '', // Generate as needed
        trainerId: trainerId,
        planName: planName,
        description: description,
        price: price,
        duration: duration,
        workouts: workouts,
        isAvailable: isAvailable,
        createdAt: DateTime.now(),
        startDate: null, // Leaving it null initially
        endDate: null, // Leaving it null initially
      );

      // Add membership plan to Firestore
      await _firestore.collection('memberships').add(membership.toJson());
    } catch (e) {
      print('Error adding membership plan: $e');
    }
  }

  // Fetch Active Memberships and map to MembershipModel
  // Fetch Active Memberships and map to MembershipModel
  // Fetch Active Memberships and map to MembershipModel
  Future<List<MembershipModel>> getAvailableMemberships() async {
    try {
      final membershipQuery = _firestore.collection('memberships').where(
          'isAvailable',
          isEqualTo: true); // Only fetch available memberships

      final querySnapshot = await membershipQuery.get();

      // Fetching and mapping membership data
      final memberships = await Future.wait(querySnapshot.docs.map((doc) async {
        final data = doc.data();
        String trainerName = 'Unknown Trainer';
        String trainerImageUrl = '';
        String trainerId = '';
        String styleOfTraining = 'Unknown Training';

        if (data.containsKey('trainerId') && data['trainerId'] is String) {
          trainerId = data['trainerId'];
          // Fetch trainer details using trainerId from the 'trainerDetails' subcollection
          try {
            final trainerDetailsDoc = await _firestore
                .collection('Profiles')
                .doc(trainerId)
                .collection('trainerDetails')
                .doc(
                    'details') // Assuming all trainers have one document under 'trainerDetails'
                .get();

            if (trainerDetailsDoc.exists) {
              final trainerDetailsData = trainerDetailsDoc.data();
              if (trainerDetailsData != null) {
                trainerName = trainerDetailsData['name'] ?? 'Unknown Trainer';
                trainerImageUrl = trainerDetailsData['profilePicture'] ?? '';
                styleOfTraining =
                    trainerDetailsData['styleOfTraining'] ?? 'Unknown Training';
              }
            } else {
              print('Trainer details document not found for $trainerId');
            }
          } catch (e) {
            print("Error fetching trainer details for $trainerId: $e");
          }
        } else {
          print('Trainer ID not found in membership data');
        }

        // Parse workouts field
        if (data.containsKey('workouts') && data['workouts'] is List) {
          final workouts = List<String>.from(data['workouts']);
          styleOfTraining = workouts.join(', ');
        }

        // Create MembershipModel
        final membershipModel = MembershipModel(
          id: doc.id,
          membershipId: data['membershipId'] ?? '',
          trainerId: trainerId,
          planName: data['planName'] ?? 'No Name',
          description: data['description'] ?? '',
          price: data['price']?.toDouble() ?? 0.0,
          duration: data['duration'] ?? '',
          workouts: List<String>.from(data['workouts'] ?? []),
          isAvailable: data['isAvailable'] ?? true,
          createdAt: (data['createdAt'] as Timestamp).toDate(),
          startDate: (data['startDate'] as Timestamp?)?.toDate(), // Nullable
          endDate: (data['endDate'] as Timestamp?)?.toDate(), // Nullable
        );

        return membershipModel; // Return the MembershipModel instance
      }).toList());

      return memberships; // Return the list of memberships
    } catch (e) {
      print("Error fetching memberships: $e");
      return []; // Return an empty list if there’s an error
    }
  }

  // Fetch Membership Details by membershipId and return MembershipModel
  Future<MembershipModel?> getMembershipDetails(String membershipId) async {
    try {
      // Fetch the membership document from the 'memberships' collection using the membershipId
      final docSnapshot =
          await _firestore.collection('memberships').doc(membershipId).get();

      // If the document exists, map the Firestore data to MembershipModel
      if (docSnapshot.exists) {
        final data = docSnapshot.data()!;

        // Parse workouts field if available
        final workouts = List<String>.from(data['workouts'] ?? []);

        // Create MembershipModel
        final membershipModel = MembershipModel(
          id: docSnapshot.id, // Document ID from Firestore
          membershipId: data['membershipId'] ?? '',
          trainerId: data['trainerId'] ?? '',
          planName: data['planName'] ?? 'No Plan Name',
          description: data['description'] ?? '',
          price: data['price']?.toDouble() ?? 0.0,
          duration: data['duration'] ?? '',
          workouts: workouts,
          isAvailable: data['isAvailable'] ?? true,
          createdAt: (data['createdAt'] as Timestamp).toDate(),
          startDate: (data['startDate'] as Timestamp?)?.toDate(), // Nullable
          endDate: (data['endDate'] as Timestamp?)?.toDate(), // Nullable
        );

        return membershipModel; // Return the mapped MembershipModel
      } else {
        print('Membership not found for membershipId: $membershipId');
        return null; // Return null if the document doesn't exist
      }
    } catch (e) {
      print('Error fetching membership details: $e');
      return null; // Return null if there's an error
    }
  }
}
