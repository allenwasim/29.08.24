import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

class VideoRepository extends GetxController {
  // Get the Firebase Firestore instance
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Singleton pattern to access instance globally
  static VideoRepository get instance => Get.find();

  // Function to upload a video tutorial to Firestore
  Future<void> uploadVideoTutorial({
    required String trainerId,
    required Map<String, dynamic> videoDetails,
  }) async {
    try {
      // Add the video details to the "Videos" collection with trainerId as a reference
      await _db.collection('Videos').add({
        ...videoDetails,
        "trainerId": trainerId, // Associate the video with the trainer
        "uploadedAt": FieldValue.serverTimestamp(), // Add timestamp
      });
    } on FirebaseException catch (e) {
      throw Exception("FirebaseException: ${e.message}");
    } on PlatformException catch (e) {
      throw Exception("PlatformException: ${e.message}");
    } catch (e) {
      throw Exception(
          'Something went wrong while uploading the video. Please try again.');
    }
  }

  // Function to fetch all videos by a specific trainer
  Future<List<Map<String, dynamic>>> fetchVideosByTrainer(
      String trainerId) async {
    try {
      // Query videos based on the trainerId
      final querySnapshot = await _db
          .collection('Videos')
          .where('trainerId', isEqualTo: trainerId)
          .orderBy('uploadedAt', descending: true)
          .get();

      // Map query results to a list of video details
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } on FirebaseException catch (e) {
      throw Exception("FirebaseException: ${e.message}");
    } on PlatformException catch (e) {
      throw Exception("PlatformException: ${e.message}");
    } catch (e) {
      throw Exception(
          'Something went wrong while fetching videos. Please try again.');
    }
  }

  // Function to fetch all videos (for the browsing section)
  Future<List<Map<String, dynamic>>> fetchAllVideos() async {
    try {
      // Fetch all videos, ordered by upload time
      final querySnapshot = await _db
          .collection('Videos')
          .orderBy('uploadedAt', descending: true)
          .get();

      // Map query results to a list of video details
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } on FirebaseException catch (e) {
      throw Exception("FirebaseException: ${e.message}");
    } on PlatformException catch (e) {
      throw Exception("PlatformException: ${e.message}");
    } catch (e) {
      throw Exception(
          'Something went wrong while fetching all videos. Please try again.');
    }
  }

  // Function to fetch a specific video by ID
  Future<Map<String, dynamic>?> fetchVideoById(String videoId) async {
    try {
      // Fetch the video document by ID
      final documentSnapshot =
          await _db.collection('Videos').doc(videoId).get();

      // Return video details if the document exists
      if (documentSnapshot.exists) {
        return documentSnapshot.data();
      } else {
        print('No video found with ID: $videoId');
        return null;
      }
    } on FirebaseException catch (e) {
      throw Exception("FirebaseException: ${e.message}");
    } on PlatformException catch (e) {
      throw Exception("PlatformException: ${e.message}");
    } catch (e) {
      throw Exception(
          'Something went wrong while fetching the video. Please try again.');
    }
  }
}
