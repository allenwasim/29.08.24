import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/appbar/appbar.dart';
import 'package:t_store/common/header/home_header.dart';
import 'package:t_store/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:t_store/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:t_store/common/widgets/text/section_header.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/user_module/features/shop/screens/address/address.dart';
import 'package:t_store/user_module/features/shop/screens/cart/cart.dart';
import 'package:t_store/user_module/features/shop/screens/order/order_screen.dart';
import 'package:t_store/utils/constants/sizes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
                child: Column(
              children: [
                TAppBar(
                  title: Text(
                    "Account",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .apply(color: TColors.white),
                  ),
                ),
                const TUserProfileTile(),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                )
              ],
            )),
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  const TSectionHeading(title: "Account Settings"),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: "My Address",
                    subTitle: "Set Shopping Delivary Address",
                    onTap: () => Get.to(() => const UserAddressScreen()),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: "My Cart",
                    subTitle: "Add, remove products and move to Checkout",
                    onTap: () => Get.to(
                      () => const CartScreen(),
                    ),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: "My Orders",
                    subTitle: "In process and complete orders",
                    onTap: () => Get.to(
                      () => const TOrderScreen(),
                    ),
                  ),
                  const TSettingsMenuTile(
                      icon: Iconsax.bank,
                      title: "Bank Account",
                      subTitle: "Withdraw blance to registered bank account"),
                  const TSettingsMenuTile(
                      icon: Iconsax.discount_shape,
                      title: "My Coupons",
                      subTitle: "List of all discounted coupons"),
                  const TSettingsMenuTile(
                      icon: Iconsax.notification,
                      title: "Notifications",
                      subTitle: "Set any kind of notification message"),
                  const TSettingsMenuTile(
                      icon: Iconsax.security_card,
                      title: "Account Privacy",
                      subTitle: "Manage Data Usage and Connected Accounts"),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  const TSectionHeading(title: "App Settings"),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  const TSettingsMenuTile(
                      icon: Iconsax.document_upload,
                      title: "Load Data",
                      subTitle: "Upload data to cloud firestore"),
                  TSettingsMenuTile(
                    icon: Iconsax.location,
                    title: "Geo Location",
                    subTitle: "Set recommentation based on location",
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  TSettingsMenuTile(
                      icon: Iconsax.document_upload,
                      title: "Safe Mode",
                      subTitle: "Search result is safe for all ages",
                      trailing: Switch(value: true, onChanged: (value) {})),
                  TSettingsMenuTile(
                      icon: Iconsax.document_upload,
                      title: "Hd image quality",
                      subTitle: "Set Image Quality to be seen",
                      trailing: Switch(value: true, onChanged: (value) {})),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
