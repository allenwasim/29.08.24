import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:t_store/utils/exceptions/firebase_exceptions.dart';

class AdminRepository extends GetxController {
  static AdminRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Add a new level to the Firestore 'levels' collection
  Future<void> addLevel(Map<String, dynamic> levelData) async {
    try {
      await _db.collection("levels").add(levelData);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw 'Failed to add level. Please try again.';
    }
  }

  // Update an existing level in the Firestore 'levels' collection
  Future<void> updateLevel(
      String levelId, Map<String, dynamic> updatedData) async {
    try {
      await _db.collection("levels").doc(levelId).update(updatedData);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw 'Failed to update level. Please try again.';
    }
  }

  // Delete a level from the Firestore 'levels' collection
  Future<void> deleteLevel(String levelId) async {
    try {
      await _db.collection("levels").doc(levelId).delete();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw 'Failed to delete level. Please try again.';
    }
  }

  // Fetch all levels from the Firestore 'levels' collection
  Future<List<Map<String, dynamic>>> getAllLevels() async {
    try {
      final querySnapshot = await _db.collection("levels").get();
      return querySnapshot.docs
          .map((doc) => {
                "id": doc.id,
                ...doc.data(),
              })
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw 'Failed to fetch levels. Please try again.';
    }
  }

  // Fetch a specific level by ID
  Future<Map<String, dynamic>> getLevelById(String levelId) async {
    try {
      final docSnapshot = await _db.collection("levels").doc(levelId).get();
      if (docSnapshot.exists) {
        return {"id": docSnapshot.id, ...docSnapshot.data()!};
      } else {
        throw 'Level not found.';
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw 'Failed to fetch level. Please try again.';
    }
  }
}
