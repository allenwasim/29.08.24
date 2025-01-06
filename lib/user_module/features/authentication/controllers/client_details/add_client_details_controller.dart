import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/user_module/data/repositories/client/client_repository.dart';
import 'package:t_store/user_module/data/repositories/user/user_repositries.dart';
import 'package:t_store/user_module/features/personalization/models/client_model.dart';
import 'package:t_store/user_module/features/personalization/controllers/user_controller.dart';
import 'package:t_store/user_module/data/repositories/authentication/authentication_repository.dart';

class AddClientDetailsController extends GetxController {
  final ClientRepository clientRepository = Get.put(ClientRepository());
  final AuthenticationRepository authenticationRepository =
      Get.put(AuthenticationRepository());
  final UserController userController = Get.put(UserController());

  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final injuriesController = TextEditingController();
  final fitnessGoalController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  var gender = 'Male'.obs; // Use .obs to make the String reactive
  String activityLevel = "Sedentary";
  String? fitnessGoal;

  final List<String> heightOptions = List.generate(49, (index) {
    int feet = 5 + index ~/ 12;
    int inches = index % 12;
    return '${feet}\'${inches}"';
  });

  final List<String> weightOptions = List.generate(58, (index) {
    return '${40 + index} kg';
  });

  final List<String> fitnessGoals = [
    "Fat Loss",
    "Weight Gain",
    "Overall Fitness",
    "Muscle Building",
    "Endurance",
    "Flexibility",
  ];

  Future<void> saveClientDetails(String userId) async {
    // Create client details object
    ClientDetails clientDetails = ClientDetails(
      userId: userId,
      height: heightController.text,
      weight: weightController.text,
      gender: gender.toString() ?? 'No t Specified',
      activityLevel: activityLevel,
      fitnessGoal: fitnessGoal ?? 'Not Specified',
      injuries: injuriesController.text,
      memberships: [],
      phoneNumber: phoneController.text,
      address: addressController.text,
      email: userController.user.value.email,
      name: userController.user.value.fullName,
      profilePic: userController.user.value.profilePicture,
    );

    // Convert ClientDetails to Map<String, dynamic> using toJson
    await clientRepository.saveClientDetails(userId, clientDetails.toJson());
    // Perform the screen redirection after saving details
    authenticationRepository.screenRedirect();

    // Optionally, go back to the previous screen after redirection
    Get.back();
  }
}
