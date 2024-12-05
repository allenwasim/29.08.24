import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/text/section_header.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TBillingAddressSection extends StatelessWidget {
  const TBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(
          title: 'Shipping Address',
          buttonTitle: 'Change',
          onPressed: () {},
        ),
        Text(
          'Coding with',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Row(
          children: [
            Icon(
              Icons.phone,
              color: Colors.grey,
              size: 16,
            ),
            SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Text(
              "9188223629",
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
        SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
        Row(
          children: [
            Icon(
              Icons.location_history,
              color: Colors.grey,
            ),
            SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Expanded(
                child: Text(
              "Shade,meenchanda,near meenchanda rly gate ,calicut",
              style: Theme.of(context).textTheme.bodyMedium,
              softWrap: true,
            ))
          ],
        )
      ],
    );
  }
}
