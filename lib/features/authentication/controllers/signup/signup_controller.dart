import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/data/repositories/user/user_repositries.dart';
import 'package:t_store/features/authentication/screens/signup/verify_email.dart';
import 'package:t_store/features/personalization/models/user_model.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/helpers/network_manager.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';
import 'package:t_store/utils/popups/loader.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final hidePassword = true.obs;
  final privacyPolicy = false.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  void signup() async {
    if (!signupFormKey.currentState!.validate()) {
      // Form is not valid, display validation errors
      return;
    }
    if (!privacyPolicy.value) {
      TLoaders.warningSnackBar(
          title: "Accept privacy policy",
          message:
              "In order to create account, you must have to read and accept the Privacy Policy and Terms of Use");
      return;
    }

    try {
      TFullScreenLoader.openLoadingDialog(
          "We are processing your information", TImages.emailVerification);

      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(
            title: "Oh snap!", message: "No internet connection");
        return;
      }

      final UserCredential userCredential =
          await AuthenticationRepository.instance.registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: "",
      );
      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
          title: "Congratulations",
          message: "Your account has been created! Verify email to continue.");
      Get.to(VerifyEmailScreen(
        email: email.text.trim(),
      ));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Oh snap!", message: e.toString());
    }
  }
}
