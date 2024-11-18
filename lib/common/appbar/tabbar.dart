import 'package:flutter/material.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/utils/device/device_utility.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TTapBar extends StatelessWidget implements PreferredSizeWidget {
  const TTapBar({super.key, required this.tabs});
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Material(
      color: dark ? TColors.black : TColors.white,
      child: Container(
        decoration: BoxDecoration(
          color: dark ? Colors.black : Colors.white,
          boxShadow: [
            BoxShadow(
              color: dark
                  ? Colors.black.withOpacity(0.6)
                  : Colors.grey.withOpacity(0.4),
              offset: Offset(0, 4), // Shadow position
              blurRadius: 3, // Shadow blur radius
            ),
          ],
        ),
        child: TabBar(
          isScrollable: true,
          unselectedLabelColor: dark ? TColors.darkGrey : TColors.grey,
          indicatorColor: dark ? Colors.white : Colors.black,
          labelColor: dark ? Colors.green : Colors.green,
          labelStyle: TextStyle(
            fontSize: 16.0, // Adjust font size as needed
            fontWeight: FontWeight.bold, // Increase boldness
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 16.0, // Adjust font size as needed
            fontWeight: FontWeight.bold, // Increase boldness
          ),
          tabs: tabs,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
