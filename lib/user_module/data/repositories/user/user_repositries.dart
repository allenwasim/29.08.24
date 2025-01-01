import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:t_store/user_module/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/user_module/features/personalization/models/user_model.dart';
import 'package:t_store/utils/exceptions/firebase_exceptions.dart';
import 'package:t_store/utils/exceptions/format_exceptions.dart';
import 'package:t_store/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final AuthenticationRepository _authRepo =
      Get.find<AuthenticationRepository>();

  /// Function to save user data to Firestore.
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("Profiles").doc(user.id).set(user.toJson());
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

  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot =
          await _db.collection("Profiles").doc(_authRepo.authUser?.uid).get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
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

  Future<void> updateUserData(UserModel updatedUser) async {
    try {
      await _db
          .collection("Profiles")
          .doc(updatedUser.id)
          .update(updatedUser.toJson());
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
      await _db
          .collection("Profiles")
          .doc(_authRepo.authUser?.uid)
          .update(json);
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

  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection("Profiles").doc(userId).delete();
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

  // Function to save trainer details to Firestore
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

  // Function to fetch trainer details from Firestore

  // Function to save client details to Firestore
  // Function to save client details to Firestore
  Future<void> saveClientDetails(
      String clientId, Map<String, dynamic> clientDetails) async {
    try {
      // Add client details to the "clientDetails" subcollection
      await _db
          .collection("Profiles")
          .doc(clientId)
          .collection('clientDetails')
          .doc('details')
          .set(clientDetails);
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

  // Function to fetch client details from Firestore
  Future<Map<String, dynamic>?> fetchClientDetails(String clientId) async {
    try {
      final documentSnapshot = await _db
          .collection("Profiles")
          .doc(
              clientId) // Use the clientId to fetch the specific client's document
          .collection('clientDetails')
          .doc(
              'details') // Assuming there's only one document named 'details' for each client
          .get();

      if (documentSnapshot.exists) {
        return documentSnapshot
            .data(); // Return the client details if the document exists
      } else {
        return null; // Return null if no client details found
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message; // Handle Firestore exceptions
    } on FormatException catch (_) {
      throw const TFormatException().message; // Handle format exceptions
    } on PlatformException catch (e) {
      throw TPlatformException(e.code)
          .message; // Handle platform-specific exceptions
    } catch (e) {
      throw 'Something went wrong. Please try again.'; // Catch any other errors
    }
  }

  // Function to add membership to clientDetails
}
