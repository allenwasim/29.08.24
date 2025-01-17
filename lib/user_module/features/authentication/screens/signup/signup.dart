import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/login_signup/form_divider.dart';
import 'package:t_store/common/widgets/login_signup/social_buttons.dart';
import 'package:t_store/user_module/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              const TSignupForm(),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              TFormDivider(
                  dark: dark, dividerText: TTexts.orSignUpWith.capitalize!),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              const TSocialButtons(
                isLogin: false,
                isTrainer: false,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              // Add a simple text below the social buttons
              TFormDivider(
                  dark: dark, dividerText: TTexts.signInAsTrainer.capitalize!),
              const SizedBox(height: TSizes.spaceBtwSections),
              // Add Google Signup Button
              const TSocialButtons(
                isLogin: false,
                isTrainer: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
