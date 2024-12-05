import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/appbar/appbar.dart';
import 'package:t_store/common/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/brands/brand_card.dart';
import 'package:t_store/common/widgets/text/section_header.dart';
import 'package:t_store/user_module/features/shop/screens/all_brands/brand_products.dart';
import 'package:t_store/utils/constants/sizes.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        title: Text("Brand"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              const TSectionHeading(
                title: "Brands",
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TGridLayout(
                    mainAxisExtent: 80,
                    itemCount: 10,
                    itemBuilder: (context, index) => TBrandCard(
                          showBorder: true,
                          onTap: () => Get.to(() => const BrandProducts()),
                        )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
