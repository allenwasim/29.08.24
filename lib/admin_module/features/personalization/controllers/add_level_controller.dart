import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
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

  // Add Level Method with parameters
  Future<void> addLevel({
    required String title,
    required String subtitle,
    required String imagePath,
    required List<Map<String, String>> exercises,
  }) async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog('Adding Level...', imagePath);

      // Form Validation
      if (addLevelFormKey.currentState == null ||
          !addLevelFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Prepare Level Data
      Map<String, dynamic> levelData = {
        "Title": title,
        "Subtitle": subtitle,
        "image": imagePath,
        "exercises": exercises,
        "levels": DateTime.now().toIso8601String(),
      };

      // Add Level to Firestore via AdminRepository
      await adminRepository.addLevel(levelData);

      // Stop Loading and show success message
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
        message: "Level added successfully!",
        title: "Success",
      );

      // Clear Form Fields
      clearForm();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
        message: e.toString(),
        title: "Error",
      );
    }
  }

  // Clear form fields after submission
  void clearForm() {
    levelNameController.clear();
    levelDescriptionController.clear();
    levelDifficulty.value = '';
  }
}
