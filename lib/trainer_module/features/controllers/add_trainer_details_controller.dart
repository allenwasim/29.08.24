import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/trainer_module/data/repositories/trainer_repository.dart';
import 'package:t_store/trainer_module/features/models/trainer_model.dart';
import 'package:t_store/user_module/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/user_module/features/personalization/controllers/user_controller.dart';

class AddTrainerController extends GetxController {
  AddTrainerController();
  final UserController userController = Get.put(UserController());

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final bioController = TextEditingController();

  // Expertise and Languages as RxSets for reactivity
  final selectedExpertise = <String>{}.obs;
  final selectedLanguages = <String>{}.obs;

  final experienceSliderValue = 0.obs;

  // Injecting dependencies
  final trainerRepository = Get.put(TrainerRepository());

  // Expertise and Languages options
  final availableWorkouts = {
    "calisthenics": "Calisthenics",
    "weight_lifting": "Weight Lifting",
    "yoga": "Yoga",
    "strength_training": "Strength Training",
    "cardio": "Cardio",
    "hiit": "HIIT",
    "meditation": "Meditation",
    "animal_movement": "Animal Movement"
  };

  final availableLanguages = {
    "English": "English",
    "Spanish": "Spanish",
    "French": "French",
    "German": "German",
    "Hindi": "Hindi",
    "Malayalam": "Malayalam", // Added Malayalam
  };

  // Add or remove expertise
  void addExpertise(String expertise) => selectedExpertise.add(expertise);
  void removeExpertise(String expertise) => selectedExpertise.remove(expertise);

  // Add or remove languages
  void addLanguage(String language) => selectedLanguages.add(language);
  void removeLanguage(String language) => selectedLanguages.remove(language);

  Future<void> saveTrainerDetails(String userId) async {
    // Create TrainerDetails object
    TrainerDetails trainerDetails = TrainerDetails(
      trainerId: userId,
      name: nameController.text.trim(),
      bio: bioController.text.trim(),
      expertise: selectedExpertise.toList(),
      yearsOfExperience: experienceSliderValue.value,
      rating: 0.0, // Default rating
      certifications: [], // Certifications can be added later
      languages: selectedLanguages.toList(),
      availability: "Available", // Default availability
      members: [],
      profilePic: userController.user.value.profilePicture,
    );

    try {
      // Save TrainerDetails to Firestore using the TrainerRepository
      await trainerRepository.saveTrainerDetails(
          userId, trainerDetails.toJson());

      // Redirect user after saving trainer details
      AuthenticationRepository.instance.screenRedirect();

      // Optionally, go back to the previous screen after redirection
      Get.back();
    } catch (e) {
      Get.snackbar("Error", "Failed to save trainer details");
    }
  }

  // Add this method inside the AddTrainerController class
  void updateExperience(int years) {
    experienceSliderValue.value = years;
  }

  @override
  void onClose() {
    nameController.dispose();
    bioController.dispose();
    super.onClose();
  }
}
