import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/user_module/data/repositories/user/user_repositries.dart';
import 'package:t_store/user_module/features/shop/screens/profile/profile.dart';
import 'package:t_store/user_module/features/personalization/controllers/user_controller.dart';
import 'package:t_store/user_module/features/personalization/models/user_model.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/helpers/network_manager.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';
import 'package:t_store/utils/popups/loader.dart';

class UpdateNameController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final userRepository = Get.put(UserRepository());
  final userController = UserController.instance;
  final user = UserModel.empty().obs;

  GlobalKey<FormState> updateNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initilizeNames();

    super.onInit();
  }

  Future<void> initilizeNames() async {
    firstNameController.text = userController.user.value.firstName;
    lastNameController.text = userController.user.value.lastName;
  }

  void fetchUserDetails() async {
    try {
      final userDetails = await userRepository.fetchUserDetails();
      user(userDetails);
      firstNameController.text = userDetails.firstName;
      lastNameController.text = userDetails.lastName;
    } catch (e) {
      user(UserModel.empty());
      TLoaders.warningSnackBar(
          title: "Error", message: "Failed to fetch user details.");
    }
  }

  void updateUserName() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          "We are upadating your information", TImages.emailVerification);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!updateNameFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      Map<String, dynamic> name = {
        'firstname': firstNameController.text.trim(),
        'lastname': lastNameController.text.trim()
      };
      await userRepository.updateSingleField(name);

      userController.user.value.firstName = firstNameController.text.trim();
      userController.user.value.lastName = lastNameController.text.trim();

      TFullScreenLoader.stopLoading();

      Get.off(() => const ProfileScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }
}
