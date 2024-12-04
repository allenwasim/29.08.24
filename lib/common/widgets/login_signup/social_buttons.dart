import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/features/authentication/controllers/login/login_controller.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TSocialButtons extends StatelessWidget {
  final bool isLogin; // Argument to check whether it's login or signup

  const TSocialButtons({
    super.key,
    required this.isLogin, // Required argument to differentiate between login and signup
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
            onPressed: () => isLogin
                ? controller.googleSignIn()
                : controller
                    .googleSignUp(), // Call the respective sign-in method
            icon: const Image(
                height: TSizes.iconMd,
                width: TSizes.iconMd,
                image: AssetImage(TImages.google))),
      ),
    );
  }
}
