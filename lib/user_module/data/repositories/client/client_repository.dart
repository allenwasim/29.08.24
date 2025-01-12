import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

class ClientRepository extends GetxController {
  // Get the Firebase Firestore instance
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Singleton pattern to access instance globally
  static ClientRepository get instance => Get.find();

  // Function to save client details to Firestore
  Future<void> saveClientDetails(
      String clientId, Map<String, dynamic> clientDetails) async {
    try {
      // Add client details to the "clientDetails" subcollection
      await _db
          .collection("Profiles")
          .doc(clientId)
          .collection('clientDetails')
          .doc('details') // Assuming each client has one document 'details'
          .set(clientDetails);
    } on FirebaseException catch (e) {
      throw Exception("FirebaseException: ${e.message}");
    } on FormatException catch (_) {
      throw const FormatException("Invalid format").message;
    } on PlatformException catch (e) {
      throw Exception("PlatformException: ${e.message}");
    } catch (e) {
      throw Exception('Something went wrong. Please try again.');
    }
  }

  // Function to fetch client details from Firestore
  Future<Map<String, dynamic>?> fetchClientDetails(String clientId) async {
    try {
      // Fetch client details from Firestore
      final documentSnapshot = await _db
          .collection("Profiles")
          .doc(clientId)
          .collection('clientDetails')
          .doc('details')
          .get();

      if (documentSnapshot.exists) {
        return documentSnapshot
            .data(); // Return the client details if the document exists
      } else {
        return null; // Return null if no client details found
      }
    } on FirebaseException catch (e) {
      throw Exception("FirebaseException: ${e.message}");
    } on FormatException catch (_) {
      throw const FormatException("Invalid format").message;
    } on PlatformException catch (e) {
      throw Exception("PlatformException: ${e.message}");
    } catch (e) {
      throw Exception('Something went wrong. Please try again.');
    }
  }

  Future<Map<String, dynamic>?> fetchMembershipById({
    required String clientId,
    required String membershipId,
  }) async {
    try {
      // Reference to the user's profile document
      DocumentReference userRef = _db
          .collection('Profiles')
          .doc(clientId)
          .collection('clientDetails')
          .doc('details');

      // Fetch the user document
      DocumentSnapshot userSnapshot = await userRef.get();

      // Check if the document exists
      if (userSnapshot.exists) {
        // Get the memberships array from the user's profile
        List<dynamic> memberships = userSnapshot['memberships'] ?? [];

        // Find the membership with the provided membershipId
        Map<String, dynamic>? membership = memberships.firstWhere(
          (membership) => membership['membershipId'] == membershipId,
          orElse: () => {},
        );

        // Return the membership data if found
        if (membership!.isNotEmpty) {
          return membership;
        } else {
          print('No membership found with ID: $membershipId');
          return null;
        }
      } else {
        print('No user found with ID: $clientId');
        return null;
      }
    } catch (e) {
      print('Error fetching memberships: $e');
      throw Exception('Failed to fetch membership');
    }
  }
}
