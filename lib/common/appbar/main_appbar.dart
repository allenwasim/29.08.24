import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/utils/constants/colors.dart';

class TMainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Color iconColor;
  final Widget titleWidget; // No need to make this reactive
  final TextStyle? textStyle; // Add a TextStyle parameter
  final List<Widget>? actions; // Optional: List of widgets for actions

  const TMainAppBar({
    required this.scaffoldKey,
    required this.iconColor,
    required this.titleWidget,
    this.textStyle, // Optional: default to null
    this.actions, // Optional: default to null
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = Get.isDarkMode; // Use GetX to check dark mode

    return AppBar(
      title: titleWidget, // Directly use the titleWidget
      elevation: 0,
      backgroundColor: dark
          ? Colors.black // Darker shade of Color(0xFF353839)
          : TColors.white,
      leading: IconButton(
        icon: Icon(Icons.menu, color: iconColor),
        onPressed: () {
          scaffoldKey.currentState?.openDrawer();
        },
      ),
      titleTextStyle: textStyle,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
