import 'package:flutter/material.dart';
import 'package:t_store/user_module/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/device/device_utility.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: TDeviceUtils.getAppBarHeight(),
        right: TSizes.defaultSpace,
        child: TextButton(
            child: const Text('skip'),
            onPressed: () => OnboardingController.instance.skipPage()));
  }
}
