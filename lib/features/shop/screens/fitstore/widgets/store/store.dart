import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:t_store/common/appbar/tabbar.dart';
import 'package:t_store/common/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/brands/brand_card.dart';
import 'package:t_store/common/widgets/searchbars/search_bar.dart';
import 'package:t_store/common/widgets/text/section_heading.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/features/shop/screens/all_brands/all_brands.dart';
import 'package:t_store/features/shop/screens/fitstore/widgets/store/widgets/category_tab.dart';
import 'package:t_store/features/shop/controllers/category_controller.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class Store extends StatelessWidget {
  const Store({super.key});

  @override
  Widget build(BuildContext context) {
    final category = CategoryController.instance.featuredCategories;
    final dark = THelperFunctions.isDarkMode(context);

    return DefaultTabController(
      length: category.length, // 5 tabs
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: 440,
                pinned: true,
                floating: true,
                backgroundColor: dark ? Colors.black : TColors.white,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(5),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const SizedBox(height: TSizes.spaceBtwItems),
                      const TSearchBar(),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      TSectionHeading(
                        title: "Featured Brands",
                        onPressed: () => Get.to(() => AllBrandsScreen()),
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems / 2),
                      GestureDetector(
                        onTap: () {},
                        child: TGridLayout(
                          mainAxisExtent: 80,
                          itemCount: 4,
                          itemBuilder: (_, index) {
                            return const TBrandCard(
                              showBorder: true,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                bottom: TTapBar(
                    tabs: category
                        .map((category) => Tab(
                              child: Text(category.name),
                            ))
                        .toList()),
              )
            ];
          },
          body: TabBarView(
            children: category
                .map((category) => TCategoryTab(category: category))
                .toList(),
          ),
        ),
      ),
    );
  }
}
