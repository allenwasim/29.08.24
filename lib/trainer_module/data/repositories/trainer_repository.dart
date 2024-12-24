// trainer_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/trainer_module/features/models/trainer_model.dart';
import 'package:t_store/user_module/features/personalization/models/user_model.dart';

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
}
