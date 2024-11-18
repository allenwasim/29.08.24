import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/product/product_card/product_card_vertical.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TSortableProducts extends StatelessWidget {
  const TSortableProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonFormField(
            items:
                ['Name', "Higher Price", "Lower Price", "Newest", "Popularity"]
                    .map((option) => DropdownMenuItem(
                          value: option,
                          child: Text(option),
                        ))
                    .toList(),
            onChanged: (value) {},
            decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        TGridLayout(
            mainAxisExtent: 288,
            itemCount: 4,
            itemBuilder: (_, index) => const TProductCardVertical())
      ],
    );
  }
}
