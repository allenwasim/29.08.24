import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TSingleAddress extends StatelessWidget {
  const TSingleAddress({super.key, required this.selectedAddress});

  final bool selectedAddress;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: TRoundedContainer(
        width: double.infinity,
        showBorder: true,
        backgroundColor:
            selectedAddress ? Colors.green.withOpacity(.5) : Colors.transparent,
        borderColor: selectedAddress
            ? Colors.transparent
            : dark
                ? TColors.darkerGrey
                : TColors.grey,
        margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
        child: Stack(
          children: [
            Positioned(
                right: 5,
                top: 0,
                child: Icon(
                  selectedAddress ? Iconsax.tick_circle5 : null,
                  color: selectedAddress
                      ? dark
                          ? TColors.light
                          : TColors.dark
                      : null,
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Allen Wasim",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: TSizes.sm / 2,
                  ),
                  Text(
                    "9188223629",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: TSizes.sm / 2,
                  ),
                  Text(
                    "Shade , Near Alankar hall, Meenchada, Calicut",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                    softWrap: true,
                  ),
                ],
              ),
            )
          ],
        ),
        // Add your content here
      ),
    );
  }
}
