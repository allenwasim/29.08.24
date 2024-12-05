import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';

class TLoginHeader extends StatelessWidget {
  const TLoginHeader({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            dark
                ? const Image(
                    height: 250,
                    image: AssetImage(TImages.darkAppLogo),
                    color: Colors.green,
                  )
                : const Image(
                    height: 250,
                    image: AssetImage(TImages.lightAppLogo),
                    color: Colors.green,
                  ),
            Positioned(
              top: 16, // Adjust the top position as needed
              left: 16, // Adjust the left position as needed
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'dopa',
                      style: Theme.of(context).textTheme.headlineLarge!.apply(
                            color: dark
                                ? const Color.fromARGB(255, 255, 255, 255)
                                : Colors.black,
                          ),
                    ),
                    TextSpan(
                      text: 'Mine',
                      style: Theme.of(context).textTheme.headlineLarge!.apply(
                            color: const Color(0xff4caf50),
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Text(
          TTexts.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: TSizes.sm,
        ),
        Text(
          TTexts.loginSubTitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
