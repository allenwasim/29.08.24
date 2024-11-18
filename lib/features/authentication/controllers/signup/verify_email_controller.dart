import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/success_screen/success_screen.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/popups/loader.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();
  var isLoading = false.obs; // Add an observable loading state

  @override
  void onInit() {
    super.onInit();
    sendEmailVerification();
    setTimerForAutoRedirect();
  }

  sendEmailVerification() async {
    isLoading.value = true; // Set loading to true
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      TLoaders.successSnackBar(
          title: "Email sent",
          message: "Please check your inbox and verify your email");
    } catch (e) {
      TLoaders.errorSnackBar(title: "Oh snap", message: e.toString());
    } finally {
      isLoading.value = false; // Set loading to false
    }
  }

  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      try {
        await FirebaseAuth.instance.currentUser?.reload();
        final user = FirebaseAuth.instance.currentUser;
        if (user?.emailVerified ?? false) {
          timer.cancel();
          Get.off(() => SuccessScreen(
              image: TImages.successFullyRegisterAnimation,
              text: TTexts.yourAccountCreatedTitle,
              subtitle: TTexts.yourAccountCreatedSubTitle,
              onPressed: () =>
                  AuthenticationRepository.instance.screenRedirect()));
        }
      } catch (e) {
        timer.cancel();
        TLoaders.errorSnackBar(title: "Error", message: e.toString());
      }
    });
  }

  checkEmailVerificationStatus() async {
    isLoading.value = true; // Set loading to true
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null && currentUser.emailVerified) {
        Get.off(() => SuccessScreen(
            image: TImages.deliveredEmailIllustration,
            text: TTexts.yourAccountCreatedTitle,
            subtitle: TTexts.yourAccountCreatedSubTitle,
            onPressed: () =>
                AuthenticationRepository.instance.screenRedirect()));
      } else {
        TLoaders.warningSnackBar(
            title: "Not Verified", message: "Your email is not verified yet.");
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: "Error", message: e.toString());
    } finally {
      isLoading.value = false; // Set loading to false
    }
  }
}
