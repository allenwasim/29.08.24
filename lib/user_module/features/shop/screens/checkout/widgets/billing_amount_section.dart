import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TBillingAmountSection extends StatelessWidget {
  const TBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Subtotal',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Expanded(
                child: Text(
                  '\$256',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems / 2,
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Shipping Fee',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Expanded(
                child: Text(
                  '\$6',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems / 2,
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Tax Fee',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Expanded(
                child: Text(
                  '\$6',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems / 2,
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Order Tax',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Expanded(
                child: Text(
                  '\$6',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems / 2,
              )
            ],
          )
        ],
      ),
    );
  }
}
