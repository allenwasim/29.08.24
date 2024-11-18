import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:t_store/common/widgets/text/section_header.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TBillingPaymentSection extends StatelessWidget {
  const TBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TSectionHeading(
            title: 'Payment Method',
            buttonTitle: 'Change',
            onPressed: () {},
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems / 2,
          ),
          Row(
            children: [
              TRoundedContainer(
                width: 60,
                height: 35,
                backgroundColor: dark ? TColors.light : TColors.white,
                child: const Image(
                  image: AssetImage(
                    TImages.paypal,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: TSizes.spaceBtwItems / 2,
              ),
              Text(
                'Paypal',
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ],
          )
        ],
      ),
    );
  }
}
