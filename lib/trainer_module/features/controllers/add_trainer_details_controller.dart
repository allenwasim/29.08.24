import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/trainer_module/data/repositories/trainer_repository.dart';
import 'package:t_store/trainer_module/features/models/trainer_model.dart';
import 'package:t_store/user_module/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/user_module/data/repositories/user/user_repositries.dart';
import 'package:t_store/user_module/features/personalization/controllers/user_controller.dart';
import 'package:t_store/user_module/features/personalization/models/user_model.dart';

class AddTrainerController extends GetxController {
  final String userId;

  AddTrainerController({required this.userId});

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final bioController = TextEditingController();
  final expertiseController = TextEditingController();
  final yearsOfExperienceController = TextEditingController();
  final ratingController = TextEditingController();
  final availabilityController = TextEditingController();
  final certificationsController = TextEditingController();
  final languagesController = TextEditingController();

  final trainerRepository = Get.put(TrainerRepository());
  final userController = Get.put(UserController());

  Future<void> submitForm() async {
    if (formKey.currentState?.validate() ?? false) {
      final trainerDetails = TrainerDetails(
        trainerId: userId,
        name: nameController.text,
        bio: bioController.text,
        expertise: expertiseController.text,
        yearsOfExperience: int.tryParse(yearsOfExperienceController.text) ?? 0,
        rating: double.tryParse(ratingController.text) ?? 0.0,
        certifications: certificationsController.text.split(','),
        languages: languagesController.text.split(','),
        availability: availabilityController.text,
        members: [],
        profilePic: userController.user.value.profilePicture,
      );

      try {
        final userModel = await UserModel.fromSnapshot(
          await FirebaseFirestore.instance
              .collection('Profiles')
              .doc(userId)
              .get(),
        );

        await trainerRepository.saveTrainerDetails(
            userId, trainerDetails.toJson());

        AuthenticationRepository.instance.screenRedirect();

        Get.back();
      } catch (e) {
        print("Error while saving trainer details: $e");
        Get.snackbar("Error", "Failed to save trainer details");
      }
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    bioController.dispose();
    expertiseController.dispose();
    yearsOfExperienceController.dispose();
    ratingController.dispose();
    availabilityController.dispose();
    certificationsController.dispose();
    languagesController.dispose();
    super.onClose();
  }
}
