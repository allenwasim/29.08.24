import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:t_store/admin_module/data/repositories/admin/admin_repositories.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';
import 'package:t_store/utils/popups/loader.dart';

class AddLevelController extends GetxController {
  static AddLevelController get instance => Get.find();

  // Repositories
  final AdminRepository adminRepository = Get.put(AdminRepository());

  // Form key
  final GlobalKey<FormState> addLevelFormKey = GlobalKey<FormState>();

  // Controllers for input fields
  final titleController = TextEditingController();
  final bannerImageController = TextEditingController();
  final stagesCountController = TextEditingController();
  final estimatedDurationController = TextEditingController();
  final levelsController = TextEditingController();
  final workoutDurationController = TextEditingController();
  final equipmentController = TextEditingController();
  final designedForController = TextEditingController();
  final overviewController = TextEditingController();

  // Observable level data
  Rx<Map<String, dynamic>?> levelData = Rx<Map<String, dynamic>?>(null);
  RxList<Map<String, dynamic>> levels = <Map<String, dynamic>>[].obs;

  Future<String> addProgrammes() async {
    try {
      // Show loading dialog
      TFullScreenLoader.openLoadingDialog(
          'Adding Programmes...', TImages.clothIcon);

      // Validate the form
      if (addLevelFormKey.currentState == null ||
          !addLevelFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return ''; // Return an empty string or handle this case as needed
      }

      // Collect programme data from controllers
      Map<String, dynamic> programmeData = {
        "title": titleController.text.trim(),
        "bannerImage": bannerImageController.text.trim(),
        "stagesCount": int.tryParse(stagesCountController.text.trim()) ?? 0,
        "estimatedDuration": estimatedDurationController.text.trim(),
        "levels": levelsController.text.trim(),
        "workoutDuration": workoutDurationController.text.trim(),
        "equipment": equipmentController.text.trim(),
        "designedFor": designedForController.text.trim(),
        "overview": overviewController.text.trim(),
      };

      // Call repository method to add programme and get the programmeId
      String programmeId = await adminRepository.saveProgramme(programmeData);

      // Hide loading dialog and notify success
      TFullScreenLoader.stopLoading();
      Get.snackbar('Success', 'Programme added successfully!');

      return programmeId; // Return the programmeId
    } catch (e) {
      // Handle errors and hide loader
      TFullScreenLoader.stopLoading();
      Get.snackbar('Error', e.toString());
      return ''; // Return an empty string or handle this case as needed
    }
  }

  @override
  void onClose() {
    // Dispose all controllers when the controller is destroyed
    titleController.dispose();
    bannerImageController.dispose();
    stagesCountController.dispose();
    estimatedDurationController.dispose();
    levelsController.dispose();
    workoutDurationController.dispose();
    equipmentController.dispose();
    designedForController.dispose();
    overviewController.dispose();

    super.onClose();
  }

  Future<void> addLevel({
    required String title,
    required String subtitle,
    required String imagePath,
    required List<Map<String, String>> exercises,
    required String programmeId, // Add programmeId as parameter
  }) async {
    try {
      TFullScreenLoader.openLoadingDialog('Adding Level...', imagePath);

      if (!addLevelFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Create level data
      Map<String, dynamic> levelData = {
        "title": title,
        "subtitle": subtitle,
        "image": imagePath,
        "exercises": exercises,
        "levels": DateTime.now().toIso8601String(),
      };

      // Call saveLevel with programmeId
      await adminRepository.saveLevel(levelData, programmeId: programmeId);

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          message: "Level added successfully!", title: "Success");
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(message: e.toString(), title: "Error");
    }
  }

  // Clear Form
  // void clearForm() {
  //   levelNameController.clear();
  //   levelDescriptionController.clear();
  //   levelDifficulty.value = '';
  // }

  // Fetch Level Details for the LevelDetailsScreen
  Future<Map<String, dynamic>?> fetchLevelDetails(
      String programmeId, // Add programmeId as parameter
      String levelTitle,
      String imagePath) async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Loading Level Details...', imagePath);

      // Fetch the level details from the Firestore subcollection "levels"
      final levelData = await FirebaseFirestore.instance
          .collection('programmes') // Root collection
          .doc(programmeId) // The specific programme document
          .collection('levels') // The subcollection where levels are stored
          .doc(
              levelTitle) // Document for the specific level (assuming levelTitle is unique)
          .get();

      // Check if the document exists
      if (levelData.exists) {
        TFullScreenLoader.stopLoading();
        return levelData.data(); // Return the level data
      } else {
        TFullScreenLoader.stopLoading();
        Get.snackbar('Error', 'Level not found');
        return null; // Return null if the document doesn't exist
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(message: e.toString(), title: "Error");
      return null; // Return null if an error occurs
    }
  }

  Future<void> mapAllLevels(String programmeId) async {
    try {
      // Show loading while fetching levels
      levels.clear();
      final allLevels = await adminRepository.getAllLevels(programmeId);
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

        // Upload the selected image to Firebase Storage

        // Get the image URL after upload

        // Now, update the level data with the uploaded image URL
        // Assuming you have a way to identify which level this image belongs to
        // Here, you can pass the level data and add the image URL to the `image` field

        // Map<String, dynamic> updatedLevelData = {
        //   "Title": levelNameController.text,
        //   "Subtitle": levelDescriptionController.text,
        //   "image": imageUrl, // Update image URL
        //   "exercises": [], // Assuming empty exercises for now
        // };

        // Assuming you have an `addLevel` method to add or update level data in Firestore
        // await adminRepository.saveLevel(updatedLevelData);

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
