import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:t_store/trainer_module/features/models/membership_model.dart';
import 'package:t_store/trainer_module/features/models/trainer_model.dart';
import 'package:t_store/utils/constants/image_strings.dart';

class MembershipRepository extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to add a membership plan and save it to Firestore
  Future<MembershipModel> addMembershipPlan(
    String trainerId,
    String name,
    String description,
    double price,
    int duration,
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
  Future<List<MembershipModel>> fetchMembershipPlansByTrainer(
      String trainerId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('memberships')
          .where('trainerId', isEqualTo: trainerId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        List<MembershipModel> memberships = snapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return MembershipModel(
            id: doc.id,
            membershipId: data['membershipId'] ?? '',
            trainerId: data['trainerId'] ?? '',
            planName: data['planName'] ?? '',
            description: data['description'] ?? '',
            price: (data['price'] ?? 0).toDouble(),
            duration: data['duration'] ?? '',
            workouts: List<String>.from(data['workouts'] ?? []),
            isAvailable: data['isAvailable'] ?? false,
            createdAt:
                (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
          );
        }).toList();

        print(
            'Fetched ${memberships.length} membership plans for Trainer ID: $trainerId');
        return memberships;
      } else {
        print('No membership plans found for Trainer ID: $trainerId');
        return [];
      }
    } catch (e) {
      print('Error fetching membership plans: $e');
      throw Exception('Failed to fetch membership plans');
    }
  }

  // Function to fetch all available memberships (isAvailable = true)
  Future<List<MembershipModel>> fetchAvailableMembershipsFromFirestore() async {
    try {
      // Fetch data from Firestore
      QuerySnapshot snapshot = await _firestore
          .collection('memberships')
          .where('isAvailable', isEqualTo: true)
          .get();

      print('Snapshot fetched: ${snapshot.docs.length} docs found.');

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

          // Debugging logs
          print('Fetched doc data: $data');

          // Safely parse 'duration' field
          int parsedDuration = 0;
          if (data['duration'] is int) {
            parsedDuration = data['duration'];
          } else if (data['duration'] is String) {
            // Try parsing the duration if it's a String
            parsedDuration = int.tryParse(data['duration']) ?? 0;
          }

          // Debug log for duration
          print('Parsed duration: $parsedDuration');

          return MembershipModel(
            id: doc.id,
            membershipId: data['membershipId'] ?? '',
            trainerId: data['trainerId'] ?? '',
            planName: data['planName'] ?? '',
            description: data['description'] ?? '',
            price: (data['price'] ?? 0).toDouble(),
            duration: parsedDuration, // Use parsed duration
            workouts: List<String>.from(data['workouts'] ?? []),
            isAvailable: data['isAvailable'] ?? false,
            createdAt:
                (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
          );
        }).toList();
      } else {
        print('No available memberships found'); // Log this case
        return []; // Return empty if no memberships are found
      }
    } catch (e) {
      // Handle errors and log the message
      print('Error fetching available membership plans: $e');
      throw Exception('Failed to fetch available membership plans');
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

  Future<void> addMembershipByUser({
    required String userId,
    required String membershipId,
    required Timestamp startDate,
    required String status,
    required int progress,
    required int duration, // duration in months
  }) async {
    try {
      // Log the operation
      print(
          'Preparing to add membership with ID: $membershipId for user: $userId');

      // Convert the `startDate` to `DateTime`
      DateTime start = startDate.toDate();

      // Calculate the end date by adding the duration (in months)
      DateTime end = start.add(Duration(days: 30 * duration));

      // Debugging logs
      print('Start Date: $start');
      print('End Date (calculated): $end');

      // Construct membership data
      Map<String, dynamic> membershipData = {
        'membershipId': membershipId,
        'startDate': startDate,
        'endDate': Timestamp.fromDate(end),
        'status': status,
        'progress': progress
      };

      // Reference to the user's profile document
      DocumentReference userRef = _firestore
          .collection('Profiles')
          .doc(userId)
          .collection('clientDetails')
          .doc('details');

      // Update the user's memberships array
      await userRef.update({
        'memberships': FieldValue.arrayUnion([membershipData]),
      });

      // Log success
      print('Membership added successfully: $membershipData');
    } catch (e) {
      print('Error adding membership for User ID: $userId: $e');
      throw Exception('Failed to add membership');
    }
  }

  Future<void> addMemberToTrainer(
    String trainerId,
    String clientId,
    String membershipId,
    String profilePic,
  ) async {
    try {
      // Create a new member object
      Member newMember = Member(
        clientId: clientId,
        membershipId: membershipId,
        profilePic: profilePic,
      );

      // Convert the member to JSON
      Map<String, dynamic> memberData = newMember.toJson();

      // Reference to the trainer's 'trainerDetails' document
      DocumentReference trainerRef = _firestore
          .collection('Profiles')
          .doc(trainerId)
          .collection('trainerDetails')
          .doc('details');

      // Add the new member to the 'members' array
      await trainerRef.update({
        'members': FieldValue.arrayUnion([memberData]),
      });

      print('Added new member for Trainer ID: $trainerId');
    } catch (e) {
      print('Error adding member to trainer: $e');
      throw Exception('Failed to add member to trainer');
    }
  }

  Future<List<Map<String, dynamic>>> fetchMembershipsByClientId(
      String clientId) async {
    try {
      // Reference to the user's profile document by clientId
      DocumentReference userRef = _firestore
          .collection('Profiles')
          .doc(clientId)
          .collection('clientDetails')
          .doc('details');

      // Fetch the user's profile document
      DocumentSnapshot userSnapshot = await userRef.get();

      // Check if the document exists and contains a 'memberships' key
      if (!userSnapshot.exists) {
        print('No profile document found for client: $clientId');
        return [];
      }

      final data = userSnapshot.data() as Map<String, dynamic>?;
      if (data == null || !data.containsKey('memberships')) {
        print('No memberships found for client: $clientId');
        return [];
      }

      // Extract the memberships array
      List<dynamic> membershipsArray = data['memberships'] as List<dynamic>;

      // List to store detailed membership info
      List<Map<String, dynamic>> memberships = [];
      for (var membership in membershipsArray) {
        String membershipId = membership['membershipId'] as String;
        Timestamp startDateTimestamp = membership['startDate'] as Timestamp;
        Timestamp endDateTimestamp = membership['endDate'] as Timestamp;

        // Convert Timestamp to DateTime (if startDate and endDate are Timestamps)
        DateTime startDate = startDateTimestamp.toDate();
        DateTime endDate = endDateTimestamp.toDate();

        // Fetch detailed membership plan info (optional)
        Map<String, dynamic> membershipDetails =
            await fetchMembershipPlan(membershipId);

        // Add start and end dates to the membership details
        Map<String, dynamic> membershipWithDates = {
          'membershipId': membershipId,
          'startDate': startDate,
          'endDate': endDate,
          ...membershipDetails, // Include other membership details
        };

        memberships.add(membershipWithDates);
      }

      return memberships;
    } catch (e) {
      print('Error fetching memberships for clientId: $clientId: $e');
      throw Exception('Failed to fetch memberships');
    }
  }

  Future<List<Map<String, dynamic>>> getClientDetailsForTrainer(
      String trainerId) async {
    try {
      final clientIds = await getClientIds(trainerId);

      List<Map<String, dynamic>> clientDetails = [];

      for (String clientId in clientIds) {
        final clientDoc = await _firestore
            .collection('Profiles')
            .doc(clientId)
            .collection('clientDetails')
            .doc('details')
            .get();

        final clientData = clientDoc.data();

        if (clientData != null) {
          clientDetails.add({
            'profilePic': clientData['profilePic'] ?? TImages.userProfileImage1,
            'name': clientData['name'],
            'email': clientData['email'],
            'phoneNumber':
                clientData['phoneNumber'], // Ensure this field exists
            'membershipStatus':
                clientData['membershipStatus'] ?? 'Not available',
            'memberships': clientData['memberships'] ?? [], // Fetch memberships
            'weight': clientData['weight'] ?? '', // Add weight field
            'height': clientData['height'] ?? '', // Add height field
            'gender':
                clientData['gender'] ?? 'Not Specified', // Add gender field
            'activityLevel': clientData['activityLevel'] ??
                'Sedentary', // Add activity level field
            'injuries': clientData['injuries'] ?? '', // Add injuries field
            'fitnessGoal':
                clientData['fitnessGoal'] ?? '', // Add fitness goal field
            'address': clientData['address'] ?? '', // Add address field
          });
        }
      }

      return clientDetails;
    } catch (e) {
      print('Error fetching client details: $e');
      throw Exception("Error fetching client details: $e");
    }
  }
}
