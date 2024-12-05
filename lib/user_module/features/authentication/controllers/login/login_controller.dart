import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:t_store/user_module/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/user_module/features/personalization/controllers/user_controller.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/helpers/network_manager.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';
import 'package:t_store/utils/popups/loader.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  // @override
  // void onInit() {
  //   email.text = localStorage.read("REMEMBER_ME_EMAIL");
  //   email.text = localStorage.read("REMEMBER_ME_PASSWORD");
  //   super.onInit();
  // }

  Future<void> emailAndPasswordSignIn() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Logging you in...', TImages.emailVerification);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(
            title: 'No Connection', message: 'No internet connection');
        return;
      }

      // Form Validation
      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Save Data if Remember Me is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Login using Email & Password
      final userCredential =
          await AuthenticationRepository.instance.loginWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );

      // Check if login is successful
      if (userCredential.user != null) {
        TFullScreenLoader.stopLoading();
        AuthenticationRepository.instance
            .screenRedirect(); // Redirect after successful login
      } else {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(
            title: 'Login Failed',
            message: 'User not found or incorrect credentials');
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      // Handle error
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  Future<void> googleSignIn() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Logging you in....', TImages.emailVerification);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }


      TFullScreenLoader.stopLoading();
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();

      TLoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
    }
  }

  Future<void> googleSignUp() async {
    try {
      TFullScreenLoader.openLoadingDialog(' ', TImages.emailVerification);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      final userCredentials =
          await AuthenticationRepository.instance.signInWithGoogle();

      await userController.saveUserRecord(userCredentials);
      TFullScreenLoader.stopLoading();
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();

      TLoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
    }
  }
}
