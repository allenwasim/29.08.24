import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/appbar/appbar.dart';
import 'package:t_store/common/icons/circular_icons.dart';
import 'package:t_store/common/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/product/product_card/product_card_vertical.dart';
import 'package:t_store/features/shop/screens/fitstore/widgets/fitstore_home/home.dart';

class FavourateItemScreen extends StatelessWidget {
  const FavourateItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          "Wishlist",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        action: [
          TCircularIcon(
              icon: Iconsax.add, onPressed: () => Get.to(() => const Home()))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              TGridLayout(
                  mainAxisExtent: 288,
                  itemCount: 4,
                  itemBuilder: (_, index) => const TProductCardVertical())
            ],
          ),
        ),
      ),
    );
  }
}
