import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/trainer_module/data/repositories/trainer_repository.dart';
import 'package:t_store/trainer_module/features/models/trainer_model.dart';
import 'package:t_store/user_module/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/user_module/features/personalization/controllers/user_controller.dart';
import 'package:t_store/user_module/features/personalization/models/user_model.dart';

class AddTrainerController extends GetxController {
  final String userId;
  final AuthenticationRepository authenticationRepository =
      Get.put(AuthenticationRepository());
  AddTrainerController({required this.userId});
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final bioController = TextEditingController();
  final RxList<String> selectedExpertise = <String>[].obs;
  final RxList<String> selectedLanguages = <String>[].obs;
  final RxDouble experienceSliderValue = 0.0.obs;

  // Available options
  final availableWorkouts = {
    'Weight Training': 'Weight Training',
    'Calisthenics': 'Calisthenics',
    'Yoga': 'Yoga',
    'Animal Movement': 'Animal Movement',
    'HIIT': 'HIIT',
    'Pilates': 'Pilates',
    'Crossfit': 'Crossfit',
    'Stretching': 'Stretching',
  };

  final availableLanguages = {
    'English': 'English',
    'Malayalam': 'Malayalam',
    'Hindi': 'Hindi',
    'Spanish': 'Spanish',
    'French': 'French',
    'German': 'German',
    'Italian': 'Italian',
    'Portuguese': 'Portuguese',
  };

  final trainerRepository = Get.put(TrainerRepository());
  final userController = Get.put(UserController());

  // Handles form submission
  Future<void> submitForm() async {
    if (formKey.currentState?.validate() ?? false) {
      // Debugging: Print the form data before proceeding
      print("Form is valid. Proceeding with submission...");
      print("Trainer ID: $userId");
      print("Name: ${nameController.text}");
      print("Bio: ${bioController.text}");
      print("Expertise: ${selectedExpertise.value.join(',')}");
      print("Years of Experience: ${experienceSliderValue.value.round()}");
      print("Languages: ${selectedLanguages.value}");
      print("Profile Pic: ${userController.user.value.profilePicture}");

      final trainerDetails = TrainerDetails(
        trainerId: userId,
        name: nameController.text,
        bio: bioController.text,
        expertise:
            selectedExpertise.value.join(','), // Use .value to access the list
        yearsOfExperience: experienceSliderValue.value.round(),
        rating: 5.5, // Placeholder rating, update as needed
        certifications: [], // Modify as needed
        languages: selectedLanguages.value, // Use .value to access the list
        availability: 'Always', // Static value, or modify as needed
        members: [], // Modify as needed
        profilePic: userController.user.value.profilePicture,
      );

      try {
        // Debugging: Before calling Firestore, print the trainer details
        print("Trainer details to save: ${trainerDetails.toJson()}");

        final userModel = await UserModel.fromSnapshot(
          await FirebaseFirestore.instance
              .collection('Profiles')
              .doc(userId)
              .get(),
        );

        print("User model retrieved successfully: $userModel");

        await trainerRepository.saveTrainerDetails(
          userId,
          trainerDetails.toJson(),
        );

        // Debugging: After successful save
        print("Trainer details saved successfully!");

        authenticationRepository.screenRedirect();
        Get.back();
      } catch (e) {
        // Debugging: If an error occurs, print the error
        print("Error while saving trainer details: $e");
        Get.snackbar(
            "Error", "Failed to save trainer details: ${e.toString()}");
      }
    } else {
      // Debugging: If form validation fails
      print("Form validation failed. Please check the input.");
    }
  }

  // Handles adding expertise
  void addExpertise(String expertise) {
    if (!selectedExpertise.contains(expertise)) {
      selectedExpertise.add(expertise);
    }
  }

  // Handles removing expertise
  void removeExpertise(String expertise) {
    selectedExpertise.remove(expertise);
  }

  // Handles adding language
  void addLanguage(String language) {
    if (!selectedLanguages.contains(language)) {
      selectedLanguages.add(language);
    }
  }

  // Handles removing language
  void removeLanguage(String language) {
    selectedLanguages.remove(language);
  }

  // Updates experience value
  void updateExperience(int index) {
    experienceSliderValue.value = index.toDouble();
  }

  @override
  void onClose() {
    nameController.dispose();
    bioController.dispose();
    super.onClose();
  }
}
