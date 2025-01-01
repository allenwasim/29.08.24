import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:t_store/trainer_module/features/models/membership_model.dart';
import 'package:t_store/trainer_module/features/models/trainer_model.dart';
import 'package:t_store/utils/exceptions/firebase_exceptions.dart';
import 'package:t_store/utils/exceptions/format_exceptions.dart';
import 'package:t_store/utils/exceptions/platform_exceptions.dart';
import 'package:get/get.dart';

class TrainerRepository extends GetxController {
  // Firebase instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Static method to access the instance of TrainerRepository
  static TrainerRepository get instance => Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fetch Trainer Details by trainerId

  // Save Trainer Details to Firestore
  Future<void> saveTrainerDetails(
      String userId, Map<String, dynamic> trainerDetails) async {
    try {
      // Add trainer details to the "trainerDetails" subcollection
      await _db
          .collection("Profiles")
          .doc(userId)
          .collection('trainerDetails')
          .doc('details')
          .set(trainerDetails);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException().message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<Map<String, dynamic>?> fetchTrainerDetails(String trainerId) async {
    try {
      final documentSnapshot = await _db
          .collection("Profiles")
          .doc(trainerId)
          .collection('trainerDetails')
          .doc('details')
          .get();
      if (documentSnapshot.exists) {
        return documentSnapshot.data();
      } else {
        return null; // Return null if no trainer details found
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException().message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
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

  // Add Membership Plan to Firestore using MembershipModel
  Future<void> addMembershipPlan(
    String trainerId,
    String planName,
    String description,
    double price,
    int duration,
    List<String> workouts,
    bool isAvailable,
  ) async {
    try {
      final membership = MembershipModel(
        id: '',
        membershipId: '',
        trainerId: trainerId,
        planName: planName,
        description: description,
        price: price,
        duration: duration,
        workouts: workouts,
        isAvailable: isAvailable,
        createdAt: DateTime.now(),
        startDate: null,
        endDate: null,
      );

      await _firestore.collection('memberships').add(membership.toJson());
    } catch (e) {
      print('Error adding membership plan: $e');
    }
  }
// Fetch Trainer Details by trainerId
}
