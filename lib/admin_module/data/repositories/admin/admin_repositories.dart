import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:t_store/user_module/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/utils/exceptions/firebase_exceptions.dart';
import 'package:t_store/utils/exceptions/format_exceptions.dart';
import 'package:t_store/utils/exceptions/platform_exceptions.dart';

class AdminRepository extends GetxController {
  static AdminRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final AuthenticationRepository _authRepo =
      Get.find<AuthenticationRepository>();

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
  // Fetch a specific level by title
  Future<Map<String, dynamic>> getLevelByTitle(String title) async {
    try {
      final querySnapshot = await _db
          .collection("levels")
          .where("title", isEqualTo: title) // Search by title
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Assuming title is unique, we return the first match
        return {
          "id": querySnapshot.docs.first.id,
          ...querySnapshot.docs.first.data()
        };
      } else {
        throw 'Level with title "$title" not found.';
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw 'Failed to fetch level by title. Please try again.';
    }
  }

  Future<String> uploadImage(String path, XFile image) async {
    try {
      // Create a reference to Firebase Storage and store the image at the provided path
      final ref = FirebaseStorage.instance.ref(path).child(image.name);

      // Upload the image file to Firebase Storage
      await ref.putFile(File(image.path));

      // Get and return the image download URL after the upload completes
      final url = await ref.getDownloadURL();
      return url;
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

  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db.collection("Users").doc(_authRepo.authUser?.uid).update(json);
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
}
