import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/sizes.dart';

final primary = TColors.primary;

class TBrandTitleText extends StatelessWidget {
  const TBrandTitleText({
    super.key,
    this.textAlign = TextAlign.center,
    this.brandTextSizes = TextSizes.small,
    required this.title,
    this.maxLines = 1,
    this.iconColor = const Color(0xFF4b68ff),
    this.textColor,
  });
  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSizes;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(
        title,
        overflow: TextOverflow.ellipsis,
        maxLines: maxLines,
        style: brandTextSizes == TextSizes.small
            ? Theme.of(context).textTheme.labelMedium!.apply(color: textColor)
            : brandTextSizes == TextSizes.medium
                ? Theme.of(context).textTheme.bodyLarge!.apply(color: textColor)
                : brandTextSizes == TextSizes.large
                    ? Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .apply(color: textColor)
                    : Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .apply(color: textColor),
      ),
      const SizedBox(
        width: TSizes.sm,
      ),
      Icon(
        Iconsax.verify5,
        color: iconColor,
        size: TSizes.iconXs,
      )
    ]);
  }
}
