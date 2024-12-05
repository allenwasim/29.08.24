import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TOrderListTile extends StatelessWidget {
  const TOrderListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return ListView.separated(
      itemCount: 5,
      shrinkWrap: true,
      separatorBuilder: (_, __) => SizedBox(height: TSizes.spaceBtwItems),
      itemBuilder: (_, index) => TRoundedContainer(
        showBorder: true,
        backgroundColor: dark ? TColors.black : TColors.light,
        padding: EdgeInsets.zero, // Remove internal padding
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // Make the container take required height
            children: [
              // Top Row for Processing Status
              Row(
                children: [
                  const Icon(Iconsax.ship),
                  const SizedBox(
                      width: TSizes.spaceBtwItems), // Spacing horizontally
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Processing",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .apply(color: TColors.primary, fontWeightDelta: 1),
                      ),
                      Text(
                        "07 Nov 2024",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                  const Spacer(), // Pushes the IconButton to the right
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Iconsax.arrow_right_34,
                      size: TSizes.iconSm,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                  height: TSizes.spaceBtwItems), // Space between sections

              // Row for Shipping Date and Order Info
              Row(
                children: [
                  // Shipping Date Section

                  // Order Info Section
                  Expanded(
                    child: Row(
                      children: [
                        const Icon(Iconsax.tag),
                        const SizedBox(
                            width:
                                TSizes.spaceBtwItems), // Spacing horizontally
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order",
                              style: Theme.of(context).textTheme.labelMedium!,
                            ),
                            Text(
                              "Order ID",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        const Icon(Iconsax.calendar),
                        const SizedBox(
                            width:
                                TSizes.spaceBtwItems), // Spacing horizontally
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Shipping date",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            Text(
                              "03 Feb 2024",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
