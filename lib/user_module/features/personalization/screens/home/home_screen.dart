import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/buttons/circular_button.dart';
import 'package:t_store/common/widgets/buttons/rounded_text_button.dart';
import 'package:t_store/common/widgets/text/grey_text.dart';
import 'package:t_store/user_module/features/personalization/screens/home/widgets/carosal_item.dart';
import 'package:t_store/user_module/features/personalization/screens/home/widgets/carosal_slider.dart';
import 'package:t_store/user_module/features/personalization/screens/memberships/memberships.dart';
import 'package:t_store/user_module/features/personalization/controllers/user_controller.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final UserController controller = Get.put(UserController());
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Obx(
                () => TGreyText(
                  text:
                      "What's New, ${controller.user.value.firstName} ?\nCheck out the latest from Training!",
                ),
              ),
            ),
            CustomCarouselSlider(
              carouselItems: [
                CarouselItem(
                  imagePath: TImages.guidanceImage1,
                  title: 'Get Fit Now',
                  subtitle: 'JOIN THE FITNESS\nREVOLUTION',
                  buttonText: 'Join Now',
                  onButtonPressed: () {},
                ),
                CarouselItem(
                    imagePath: TImages.browseImage1,
                    title: 'Athlete-inspired workouts',
                    subtitle: 'TRAIN LIKE YOUR\nFAVE ATHLETE',
                    buttonText: 'Move With Us',
                    onButtonPressed: () {}),
                CarouselItem(
                  imagePath: TImages.guidanceImage3,
                  title: 'Stay Motivated',
                  subtitle: 'KEEP PUSHING\nYOUR LIMITS',
                  buttonText: 'Start Now',
                  onButtonPressed: () => Get.to(() => const Memberships()),
                ),
              ],
            ),
            TRoundedTextButton(
              text: "View All",
              onPressed: () {},
            ),
            Container(
              padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      "assets/images/content/download.png",
                      color:
                          isDarkMode ? const Color(0xFF32CD32) : Colors.green,
                      height: 150,
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: TGreyText(
                      text: "Looking for dopaMine?\nLet's do a workout!",
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      height: 60,
                      width: 210,
                      child: TCircularButton(
                        text: "Explore workouts",
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
