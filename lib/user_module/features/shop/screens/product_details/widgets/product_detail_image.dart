import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/appbar/appbar.dart';
import 'package:t_store/common/icons/circular_icons.dart';
import 'package:t_store/common/images/rounded_image.dart';
import 'package:t_store/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return TCurvedEdges(
      child: Container(
        color: dark ? TColors.darkerGrey : TColors.grey,
        child: Stack(
          children: [
            const SizedBox(
              height: 400,
              child: Padding(
                padding: EdgeInsets.all(TSizes.productImageRadius * 2),
                child: Center(
                    child: Image(image: AssetImage(TImages.productImage1))),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 30,
              left: TSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (_, __) => const SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  itemCount: 4,
                  itemBuilder: (_, index) => TRoundedImage(
                    imageUrl: TImages.productImage1,
                    width: 80,
                    border: Border.all(color: Colors.green),
                    backgroundColor: dark ? TColors.black : TColors.light,
                    padding: const EdgeInsets.all(TSizes.sm),
                  ),
                ),
              ),
            ),
            const TAppBar(
              showBackArrow: true,
              action: [
                TCircularIcon(
                  icon: Iconsax.heart5,
                  color: Colors.red,
                  backgroundColor: Color.fromARGB(255, 40, 40, 40),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
