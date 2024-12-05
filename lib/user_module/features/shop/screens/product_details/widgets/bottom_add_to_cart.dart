import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/icons/circular_icons.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TBottomAddToCart extends StatelessWidget {
  const TBottomAddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(
          horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
      decoration: BoxDecoration(
          color: dark ? TColors.darkerGrey : TColors.light,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(
                TSizes.cardRadiusLg,
              ),
              topRight: Radius.circular(TSizes.cardRadiusLg))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              TCircularIcon(
                  icon: Iconsax.minus,
                  backgroundColor: TColors.darkGrey,
                  width: 40,
                  height: 40,
                  color: TColors.white),
              SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              Text(
                "2",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              TCircularIcon(
                  icon: Iconsax.add,
                  backgroundColor: TColors.black,
                  width: 40,
                  height: 40,
                  color: TColors.white),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("Add to cart"),
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(TSizes.md),
                backgroundColor: TColors.black,
                side: BorderSide(color: TColors.black)),
          )
        ],
      ),
    );
  }
}
