import 'package:flutter/material.dart';
import 'package:t_store/common/images/rounded_image.dart';
import 'package:t_store/common/widgets/brands/brand_text_verified.dart';
import 'package:t_store/common/widgets/text/product_title_text.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TCartItem extends StatelessWidget {
  const TCartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Row(
      children: [
        TRoundedImage(
          imageUrl: TImages.productImage1,
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(TSizes.sm),
          backgroundColor: dark ? TColors.darkerGrey : TColors.light,
        ),
        const SizedBox(
          width: TSizes.spaceBtwItems,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TBrandTitleWithVerifiedIcon(title: "nike"),
            Flexible(
              child: TProductTitleText(
                title: "Black Spaorts Shoes",
                maxLines: 1,
              ),
            ),
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: 'Color ', style: Theme.of(context).textTheme.bodySmall),
              TextSpan(
                  text: 'Green ', style: Theme.of(context).textTheme.bodyLarge),
              TextSpan(
                  text: 'Size ', style: Theme.of(context).textTheme.bodySmall),
              TextSpan(
                  text: 'Uk 08', style: Theme.of(context).textTheme.bodyLarge),
            ]))
          ],
        )
      ],
    );
  }
}
