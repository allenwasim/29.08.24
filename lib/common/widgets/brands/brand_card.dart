import 'package:flutter/material.dart';
import 'package:t_store/common/images/circular_image.dart';
import 'package:t_store/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:t_store/common/widgets/text/brand_title_text.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TBrandCard extends StatelessWidget {
  const TBrandCard({
    super.key,
    required this.showBorder,
    this.onTap,
  });
  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
        onTap: onTap,
        child: TRoundedContainer(
            padding: const EdgeInsets.all(0),
            showBorder: showBorder,
            backgroundColor: Colors.transparent,
            child: Row(
              children: [
                Flexible(
                  child: TCircularImage(
                    image: TImages.nikeLogo,
                    isNetworkImage: false,
                    backgroundColor: Colors.transparent,
                    overlayColor: dark ? TColors.white : TColors.dark,
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems / 2,
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TBrandTitleText(
                        title: "Nike",
                        brandTextSizes: TextSizes.large,
                      ),
                      Text(
                        '256 products ',
                        style: Theme.of(context).textTheme.labelMedium,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                )
              ],
            )));
  }
}
