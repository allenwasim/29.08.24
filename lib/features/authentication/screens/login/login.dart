import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/admin_module/features/personalization/add_stage.dart';
import 'package:t_store/admin_module/features/authentication/screens/admin_login/admin_login.dart';
import 'package:t_store/common/styles/spacing_styles.dart';
import 'package:t_store/common/widgets/login_signup/social_buttons.dart';
import 'package:t_store/common/widgets/login_signup/form_divider.dart';
import 'package:t_store/features/authentication/screens/login/widgets/login_form.dart';
import 'package:t_store/features/authentication/screens/login/widgets/login_header.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              TLoginHeader(dark: dark),
              const TLoginForm(),
              TFormDivider(
                dark: dark,
                dividerText: TTexts.orSignInWith.capitalize!,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              const TSocialButtons(),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              // Add "Login as Admin" at the bottom
              GestureDetector(
                onTap: () {
                  Get.to(
                      () => AdminLoginScreen()); // Navigate to AddLevelScreen
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    "Login as admin".capitalize!,
                    style: TextStyle(
                      color: dark ? Colors.lightBlueAccent : Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
