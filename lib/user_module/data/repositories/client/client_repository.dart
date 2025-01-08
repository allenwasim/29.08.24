import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

import 'package:t_store/trainer_module/features/sections/members/widgets/web_page_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

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

  void navigateToGoogleMeet(String meetLink) {
    try {
      if (meetLink.isNotEmpty) {
        // Navigate to the Google Meet link
        Get.to(() => LiveSessionScreen(
              meetUrl: meetLink,
            ));
        // Handle the case where the meet link is empty or invalid
        Get.snackbar("Error", "Meet link is not available.");
      }
    } catch (e) {
      // Handle errors, if any
      Get.snackbar("Error", "Failed to navigate to Google Meet.");
    }
  }
}
