import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/appbar/appbar.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/features/shop/screens/address/add_new_address.dart';
import 'package:t_store/features/shop/screens/address/widgets/single_address.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColors.primary,
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        child: Icon(Icons.add, color: TColors.white),
      ),
      appBar: TAppBar(
        showBackArrow: true,
        title:
            Text('Addresses', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(0),
        child: Column(
          children: [
            TSingleAddress(selectedAddress: true),
            TSingleAddress(selectedAddress: false),
            TSingleAddress(selectedAddress: false),
            // Additional widgets or containers can go here
          ],
        ),
      ),
    );
  }
}
