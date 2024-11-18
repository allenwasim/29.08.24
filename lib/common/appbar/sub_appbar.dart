import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TSubAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<String> tabs;
  final TabController tabController;
  final Color color;

  const TSubAppBar({
    super.key,
    required this.tabs,
    required this.tabController,
    this.color = Colors.green,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Container(
      decoration: BoxDecoration(
        color: dark ? Colors.black : Colors.white,
        boxShadow: [
          BoxShadow(
            color: dark
                ? Colors.black.withOpacity(0.6)
                : Colors.grey.withOpacity(0.3),
            offset: Offset(0, 4), // Shadow position
            blurRadius: 8, // Shadow blur radius
          ),
        ],
      ),
      child: AppBar(
        backgroundColor: dark ? Colors.black : TColors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: dark ? Colors.white : Colors.black),
        bottom: PreferredSize(
          preferredSize:
              const Size.fromHeight(48.0), // Height of TabBar including shadow
          child: TabBar(
            controller: tabController,
            labelColor: dark ? const Color(0xFF32CD32) : color,
            unselectedLabelColor: dark ? TColors.darkerGrey : TColors.darkGrey,
            indicatorColor: dark ? Colors.white : Colors.black,
            indicatorWeight: 4.0, // Customize indicator thickness if needed
            labelStyle:
                const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
            unselectedLabelStyle:
                const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
            labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
            tabs: tabs.map((tab) => Tab(text: tab)).toList(),
            dividerColor: dark
                ? const Color.fromARGB(255, 28, 28, 28)
                : Colors.grey[300], // Hide the line other than the indicator
          ),
        ),
        toolbarHeight: 48.0, // Height of AppBar without extra space
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(50.0); // Height adjusted to include TabBar
}
