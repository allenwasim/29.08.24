import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/text/grey_text.dart';
import 'package:t_store/common/widgets/text/section_header.dart';
import 'package:t_store/features/personalization/screens/training/guidance/widgets/scrollable_image.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class GuidancePage extends StatelessWidget {
  const GuidancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // Featured Tips Title with Accent Color
              const TSectionHeading(
                title: 'Featured Tips',
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const TGreyText(
                text:
                    "Nutrition and healthy habits to help you feel good all round",
              ),
              const SizedBox(height: 8),
              // Use the TScrollableImage widget with meaningful titles and subtitles
              TScrollableImage(
                items: [
                  CarouselItem(
                      imagePath: TImages.guidanceImage2,
                      title: 'Stay Hydrated',
                      subtitle: "Coaching",
                      onButtonPressed: () {}),
                  CarouselItem(
                      imagePath: TImages.guidanceImage3,
                      title: 'Perfect Your Form',
                      subtitle: "Coaching",
                      onButtonPressed: () {}),
                  CarouselItem(
                      imagePath: TImages.guidanceImage1,
                      title: 'Ramp Up the Intensity',
                      subtitle: "Coaching",
                      onButtonPressed: () {}),
                ],
              ),
              const TSectionHeading(
                title: 'Movement Tips',
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              TScrollableImage(
                items: [
                  CarouselItem(
                      imagePath: TImages.homeimage1,
                      title: 'Ramp Up the Intensity',
                      subtitle: "Coaching",
                      onButtonPressed: () {}),
                  CarouselItem(
                      imagePath: TImages.homeimage2,
                      title: 'Stay Hydrated',
                      subtitle: "Coaching",
                      onButtonPressed: () {}),
                  CarouselItem(
                      imagePath: TImages.homeimage3,
                      title: 'Perfect Your Form',
                      subtitle: "Coaching",
                      onButtonPressed: () {}),
                ],
              ),

              // Movement Tips Section (You can add similar widgets here)
            ],
          ),
        ),
      ),
    );
  }
}
