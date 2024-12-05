import 'package:flutter/material.dart';
import 'package:t_store/common/appbar/appbar.dart';
import 'package:t_store/user_module/features/shop/screens/order/widgets/order_list_items.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TOrderScreen extends StatelessWidget {
  const TOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          "My Orders",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: TOrderListTile(),
      ),
    );
  }
}
