import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/user_module/features/personalization/screens/training/training.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TCircularButton extends StatelessWidget {
  const TCircularButton({
    super.key,
    required this.text,
    this.textColor,
  });

  final String text;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = THelperFunctions.isDarkMode(context);

    return OutlinedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isDarkMode ? TColors.lightGrey : TColors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(70.0),
        ),
      ),
      onPressed: () => Get.to(() => const Training()),
      focusNode: FocusNode(skipTraversal: true), // Remove blue outline
      child: Text(
        text,
        style: Theme.of(context).textTheme.headlineSmall!.apply(
              color: textColor ??
                  (isDarkMode
                      ? const Color.fromARGB(255, 0, 0, 0)
                      : TColors.white),
            ),
      ),
    );
  }
}
