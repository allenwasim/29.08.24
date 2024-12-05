import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:readmore/readmore.dart';
import 'package:t_store/common/widgets/text/section_header.dart';

import 'package:t_store/user_module/features/shop/screens/product_details/widgets/bottom_add_to_cart.dart';
import 'package:t_store/user_module/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:t_store/user_module/features/shop/screens/product_details/widgets/product_detail_image.dart';
import 'package:t_store/user_module/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:t_store/user_module/features/shop/screens/product_details/widgets/rating_share.dart';
import 'package:t_store/user_module/features/shop/screens/product_review_screen.dart/product_reviews.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    THelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: const TBottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TProductImageSlider(),
            Padding(
              padding: const EdgeInsets.only(
                  right: TSizes.defaultSpace,
                  left: TSizes.defaultSpace,
                  top: TSizes.defaultSpace),
              child: Column(
                children: [
                  const TRatingAndShare(),
                  const TProductMetaData(),
                  const TProductAttributes(),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {}, child: const Text("Checkout"))),
                  const TSectionHeading(title: "Describtion"),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  const ReadMoreText(
                    "this is product describtion.there can be more things added.this is a very very good shoe,plese buy it ",
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: "Show more",
                    trimExpandedText: "Show Less",
                    moreStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  TSectionHeading(
                    title: "Reviews(199)",
                    onPressed: () => Get.to(() => TProductReviewsScreen()),
                    showActionButton: true,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
