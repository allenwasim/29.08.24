import 'package:flutter/material.dart';
import 'package:t_store/common/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/brands/brand_show_case.dart';
import 'package:t_store/common/widgets/product/product_card/product_card_vertical.dart';
import 'package:t_store/common/widgets/text/section_header.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TCategoryTab extends StatelessWidget {
  final category; // Add category field

  const TCategoryTab({
    super.key,
    required this.category, // Add category to constructor
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.only(top: TSizes.defaultSpace),
          child: SingleChildScrollView(
            child: Column(
              // Make content scrollable
              children: [
                const TBrandShowCase(
                  images: [
                    TImages.productImage1,
                    TImages.productImage2,
                    TImages.productImage3
                  ],
                ),
                const TBrandShowCase(
                  images: [
                    TImages.productImage1,
                    TImages.productImage2,
                    TImages.productImage3
                  ],
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                TSectionHeading(
                  title: "$category You Might Like", // Use category here
                  showActionButton: true,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                TGridLayout(
                  mainAxisExtent: 288,
                  itemCount: 4,
                  itemBuilder: (_, index) => const TProductCardVertical(),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
