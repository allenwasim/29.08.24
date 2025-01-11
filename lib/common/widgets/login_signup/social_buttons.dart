import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/user_module/features/authentication/controllers/login/login_controller.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TSocialButtons extends StatelessWidget {
  final bool isLogin; // Argument to check whether it's login or signup
  final bool isTrainer; // Argument to check if it's for trainer login/signup

  const TSocialButtons({
    super.key,
    required this.isLogin, // Required argument to differentiate between login and signup
    this.isTrainer =
        false, // New argument to differentiate between trainer and normal user
  });

  @override
  Widget build(BuildContext context) {
    // Use the appropriate controller based on the isLogin argument
    final controller = Get.put(LoginController());

    return Center(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: TColors.grey),
            borderRadius: BorderRadius.circular(100)),
        child: IconButton(
          onPressed: () {
            if (isLogin) {
              // Check if it's trainer login or regular login
              controller.googleSignIn();
            } else {
              // Check if it's trainer sign-up or regular sign-up
              isTrainer
                  ? controller.googleSignUp(
                      isTrainer: true) // Trainer-specific sign-up
                  : controller.googleSignUp(
                      isTrainer: false); // Regular sign-up
            }
          },
          icon: const Image(
            height: TSizes.iconMd,
            width: TSizes.iconMd,
            image: AssetImage(TImages.google),
          ),
        ),
      ),
    );
  }
}
