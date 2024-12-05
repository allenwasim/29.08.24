import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/user_module/features/shop/screens/all_products/all_products.dart';
import 'package:t_store/user_module/features/shop/screens/fitstore/widgets/fitstore_home/widgets/home_appbar.dart';
import 'package:t_store/common/header/home_header.dart';
import 'package:t_store/common/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/product/product_card/product_card_vertical.dart';
import 'package:t_store/common/widgets/searchbars/search_bar.dart';
import 'package:t_store/common/widgets/text/section_header.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/user_module/features/shop/screens/fitstore/widgets/fitstore_home/widgets/home_categories.dart';
import 'package:t_store/user_module/features/shop/screens/fitstore/widgets/fitstore_home/widgets/promo_slider.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  THomeBar(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          TTexts.homeAppbarTitle,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .apply(color: dark ? Colors.grey : TColors.grey),
                        ),
                        Text(
                          "Allen Wasim k",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .apply(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const TSearchBar(
                    textColor: Colors.white,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        TSectionHeading(
                          title: "Popular Categories ",
                          textColor: Colors.white,
                        ),
                        SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                        THomeCategories()
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: TPromoSlider(banners: [
                TImages.promoBanner1,
                TImages.promoBanner2,
                TImages.promoBanner3,
              ]),
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            TSectionHeading(
              title: "Popular Products",
              onPressed: () => Get.to(() => const AllProducts()),
              showActionButton: true,
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            TGridLayout(
                mainAxisExtent: 288,
                itemCount: 4,
                itemBuilder: (_, index) => const TProductCardVertical())
          ],
        ),
      ),
    );
  }
}
