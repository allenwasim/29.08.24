import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:t_store/common/appbar/appbar.dart';

import 'package:t_store/user_module/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:t_store/user_module/features/shop/screens/checkout/checkout.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'cart',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: TCartItems(),
      ),
      bottomNavigationBar: ElevatedButton(
          onPressed: () => Get.to(() => const CheckoutScreen()),
          child: const Text('Checkout \$256')),
    );
  }
}
