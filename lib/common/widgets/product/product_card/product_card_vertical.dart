import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/icons/circular_icons.dart';
import 'package:t_store/common/images/rounded_image.dart';
import 'package:t_store/common/styles/shadow_style.dart';
import 'package:t_store/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:t_store/common/widgets/text/brand_title_text.dart';
import 'package:t_store/common/widgets/text/product_price_text.dart';
import 'package:t_store/common/widgets/text/product_title_text.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/user_module/features/shop/screens/product_details/product_details.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetail()),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            boxShadow: [TShadowStyle.verticalProductShadow],
            borderRadius: BorderRadius.circular(TSizes.productImageRadius),
            color: dark ? TColors.black : TColors.grey),
        child: Column(
          children: [
            TRoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.all(0),
              backgroundColor: dark ? TColors.darkerGrey : TColors.light,
              child: Stack(
                children: [
                  const TRoundedImage(
                    imageUrl: TImages.productImage1,
                    applyImageRadius: true,
                  ),
                  Positioned(
                    top: 6,
                    child: TRoundedContainer(
                      height: 28,
                      backgroundColor: TColors.secondary.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                          vertical: TSizes.sm, horizontal: TSizes.xs),
                      radius: TSizes.sm,
                      child: Text(
                        "25%",
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .apply(color: TColors.black),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 1,
                    right: 0,
                    child: TCircularIcon(
                      backgroundColor: dark ? TColors.black : TColors.white,
                      icon: Iconsax.heart5,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: TSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TProductTitleText(
                    title: "Green Nike Air Shoes",
                    smallSize: true,
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwItems / 2,
                  ),
                  TBrandTitleText(
                    title: "Nike",
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: TSizes.sm),
                  child: TProductPriceText(
                    price: '30.99',
                    isLarge: false,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(TSizes.cardRadiusMd),
                          bottomRight:
                              Radius.circular(TSizes.productImageRadius))),
                  child: const SizedBox(
                    width: TSizes.iconLg * 1.2,
                    height: TSizes.iconLg * 1.2,
                    child: Center(
                      child: Icon(
                        Iconsax.add,
                        color: Colors.green,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
