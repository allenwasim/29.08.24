import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/features/shop/screens/cart/cart.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TCartCounterIcon extends StatelessWidget {
  const TCartCounterIcon({
    super.key,
    required this.onPressed,
    this.iconColor,
  });
  final VoidCallback onPressed;
  final Color? iconColor;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Stack(
      children: [
        IconButton(
          onPressed: () => Get.to(() => const CartScreen()),
          icon: const Icon(Iconsax.shopping_bag),
          color: dark ? Colors.white : TColors.black,
        ),
        Positioned(
            right: 0,
            child: Container(
                height: 18,
                width: 18,
                decoration: BoxDecoration(
                    color: dark ? Colors.green : TColors.black,
                    borderRadius: BorderRadius.circular(100)),
                child: Center(
                  child: Text(
                    '2',
                    style: Theme.of(context).textTheme.labelLarge!.apply(
                        color: dark ? TColors.black : TColors.white,
                        fontSizeFactor: 0.8),
                  ),
                )))
      ],
    );
  }
}
