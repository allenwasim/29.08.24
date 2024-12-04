import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:t_store/admin_module/data/repositories/admin/admin_repositories.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';
import 'package:t_store/utils/popups/loader.dart';

class AddLevelController extends GetxController {
  static AddLevelController get instance => Get.find();

  final adminRepository = Get.put(AdminRepository());
  final levelNameController = TextEditingController();
  final levelDescriptionController = TextEditingController();
  final levelDifficulty = ''.obs; // Example for dropdown or selection
  GlobalKey<FormState> addLevelFormKey = GlobalKey<FormState>();
  Rx<Map<String, dynamic>?> levelData = Rx<Map<String, dynamic>?>(null);
  RxList<Map<String, dynamic>> levels = <Map<String, dynamic>>[].obs;

  // Add Level Method
  Future<void> addLevel({
    required String title,
    required String subtitle,
    required String imagePath,
    required List<Map<String, String>> exercises,
  }) async {
    try {
      TFullScreenLoader.openLoadingDialog('Adding Level...', imagePath);

      if (addLevelFormKey.currentState == null ||
          !addLevelFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      Map<String, dynamic> levelData = {
        "Title": title,
        "Subtitle": subtitle,
        "image": imagePath,
        "exercises": exercises,
        "levels": DateTime.now().toIso8601String(),
      };

      await adminRepository.addLevel(levelData);

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
        message: "Level added successfully!",
        title: "Success",
      );

      clearForm();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
        message: e.toString(),
        title: "Error",
      );
    }
  }

  // Clear Form
  void clearForm() {
    levelNameController.clear();
    levelDescriptionController.clear();
    levelDifficulty.value = '';
  }

  // Fetch Level Details for the LevelDetailsScreen
  Future<Map<String, dynamic>?> fetchLevelDetails(
      String levelTitle, String imagePath) async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Loading Level Details...', imagePath);
      final levelData =
          await adminRepository.getLevelByTitle(levelTitle); // Change here
      TFullScreenLoader.stopLoading();
      return levelData;
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(message: e.toString(), title: "Error");
      return null; // Return null if an error occurs
    }
  }

  Future<void> mapAllLevels() async {
    try {
      // Show loading while fetching levels
      levels.clear();
      final allLevels = await adminRepository.getAllLevels();
      levels.addAll(allLevels);
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> uploadlevelimage() async {
    // Open image picker to select an image from the gallery
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
      maxHeight: 512,
      maxWidth: 512,
    );

    if (image != null) {
      try {
        // Show loading dialog while the image is being uploaded
        TFullScreenLoader.openLoadingDialog(
            'Uploading Level Image...', image.path);

        // Create a reference to Firebase Storage with a path where the image will be saved
        final storageRef = FirebaseStorage.instance.ref().child(
            "Levels/Images/${DateTime.now().millisecondsSinceEpoch}.jpg");

        // Upload the selected image to Firebase Storage
        final uploadTask = await storageRef.putFile(File(image.path));

        // Get the image URL after upload
        final imageUrl = await uploadTask.ref.getDownloadURL();

        // Now, update the level data with the uploaded image URL
        // Assuming you have a way to identify which level this image belongs to
        // Here, you can pass the level data and add the image URL to the `image` field

        Map<String, dynamic> updatedLevelData = {
          "Title": levelNameController.text,
          "Subtitle": levelDescriptionController.text,
          "image": imageUrl, // Update image URL
          "exercises": [], // Assuming empty exercises for now
        };

        // Assuming you have an `addLevel` method to add or update level data in Firestore
        await adminRepository.addLevel(updatedLevelData);

        // Stop the loading dialog
        TFullScreenLoader.stopLoading();

        // Show success message
        TLoaders.successSnackBar(
          title: "Level Image Uploaded",
          message: "The level image has been uploaded successfully!",
        );
      } catch (e) {
        // Stop the loading dialog in case of an error
        TFullScreenLoader.stopLoading();

        // Show error message
        TLoaders.warningSnackBar(
          title: "Upload Failed",
          message:
              "There was an issue uploading the level image. Please try again.",
        );
      }
    }
  }
}
