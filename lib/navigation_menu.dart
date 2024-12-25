import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/images/circular_image.dart';
import 'package:t_store/common/appbar/main_appbar.dart';
import 'package:t_store/common/widgets/product/cart/cart_menu_icon.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/user_module/features/personalization/screens/home/home_screen.dart';
import 'package:t_store/user_module/features/personalization/screens/memberships/memberships.dart';
import 'package:t_store/user_module/features/shop/screens/profile/profile.dart';
import 'package:t_store/user_module/features/personalization/screens/programmes/programmes.dart';
import 'package:t_store/user_module/features/shop/screens/fitstore/fitstore.dart';
import 'package:t_store/user_module/features/personalization/screens/training/training.dart';
import 'package:t_store/user_module/features/personalization/controllers/user_controller.dart';
import 'package:t_store/user_module/features/shop/screens/fitstore/widgets/settings/settings.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class UserNavigationMenu extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  UserNavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController controller = Get.put(UserController());
    final NavigationController navigationController =
        Get.put(NavigationController());
    final dark = THelperFunctions.isDarkMode(context);
    final iconColor =
        dark ? const Color.fromARGB(255, 255, 255, 255) : Colors.black;

    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(
          () => Container(
            decoration: BoxDecoration(
              boxShadow: navigationController.selectedIndex.value == 2
                  ? [
                      BoxShadow(
                        color:
                            dark ? Colors.black : Colors.grey.withOpacity(0.3),
                        offset: const Offset(0, 4), // Shadow position
                        blurRadius: 8, // Shadow blur radius
                      ),
                    ]
                  : [], // No shadow if not on Dopamine screen
            ),
            child: TMainAppBar(
              scaffoldKey: _scaffoldKey,
              iconColor: iconColor,
              titleWidget:
                  Obx(() => navigationController.getTitleWidget(dark, context)),
              actions: [
                // Conditionally show TCartCounterIcon for FitStore (index 3)
                Obx(() {
                  if (navigationController.selectedIndex.value == 3) {
                    return TCartCounterIcon(
                      onPressed: () {
                        // Handle cart icon press
                      },
                      iconColor: TColors.white,
                    );
                  } else {
                    return IconButton(
                      icon: Icon(
                        Icons.person_add_alt_rounded,
                        color: dark ? Colors.white : Colors.black,
                        size: 24, // Adjust size as needed
                      ),
                      onPressed: () {
                        // Handle user icon press
                      },
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
      body: Obx(
        () => Column(
          children: [
            if (navigationController.selectedIndex.value == 2)
              Container(
                height: 2.0, // Reduced height for the line
                decoration: BoxDecoration(
                  color: dark
                      ? Colors.black
                      : Colors
                          .white, // Same as background color to simulate a divider
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Lighter shadow
                      spreadRadius: 1, // Reduced spread
                      blurRadius: 1, // Lighter shadow
                      offset: const Offset(0, 1), // Reduced offset
                    ),
                  ],
                ),
              ),
            Expanded(
              child: Obx(() => navigationController
                  .screens[navigationController.selectedIndex.value]),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor:
            dark ? const Color.fromARGB(255, 25, 25, 25) : Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()),
                );
              },
              child: UserAccountsDrawerHeader(
                accountName: Obx(() {
                  return Text(
                    controller.user.value.fullName,
                    style: Theme.of(context).textTheme.headlineSmall,
                  );
                }),
                accountEmail: Obx(() {
                  return Text(
                    controller.user.value.email,
                    style: Theme.of(context).textTheme.bodyMedium,
                  );
                }),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                currentAccountPicture: Obx(
                  () => TCircularImage(
                    isNetworkImage: true,
                    image: controller.user.value.profilePicture,
                    width: 80,
                    height: 80,
                  ),
                ),
              ),
            ),
            buildListTile(context, navigationController, iconColor, Icons.timer,
                'Training', 0),
            buildListTile(context, navigationController, iconColor, Icons.timer,
                'Programmes', 1),
            buildListTile(context, navigationController, iconColor, Icons.home,
                'Home', 2),
            buildListTile(context, navigationController, iconColor,
                Icons.shopping_cart, 'FitStore', 3),
            buildListTile(context, navigationController, iconColor,
                Icons.accessibility, 'Memberships', 4),
            const Divider(),
            buildListTile(context, navigationController, iconColor,
                Icons.settings, 'Settings', 5),
          ],
        ),
      ),
    );
  }

  ListTile buildListTile(BuildContext context, NavigationController controller,
      Color iconColor, IconData icon, String title, int index) {
    return ListTile(
      leading: Obx(() => Icon(
            icon,
            color: controller.selectedIndex.value == index
                ? iconColor
                : Colors.grey,
          )),
      title: Obx(() => Text(
            title,
            style: TextStyle(
              color: controller.selectedIndex.value == index
                  ? iconColor
                  : Colors.grey,
            ),
          )),
      onTap: () {
        controller.updateTitle(title, index);
        controller.selectedIndex.value = index;
        Navigator.pop(context);
      },
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 2.obs;
  final Rx<Widget> titleWidget = Rx<Widget>(Container());

  final screens = [
    const Training(),
    ProgrammesScreen(),
    const Home(),
    const FitStore(), // FitStore screen
    const Memberships(),
    const SettingsScreen(),
  ];

  void updateTitle(String newTitle, int index) {
    final textStyle = Get.textTheme.headlineMedium?.copyWith(
      fontSize: 22,
      fontWeight: FontWeight.w500,
    );

    titleWidget.value = Text(
      newTitle,
      style: textStyle,
    );
  }

  Widget getTitleWidget(bool dark, BuildContext context) {
    final textStyle = Get.textTheme.headlineMedium?.copyWith(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );

    return selectedIndex.value == 2
        ? Row(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'dopa',
                      style: textStyle?.copyWith(
                        color: dark ? Colors.white : Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'Mine',
                      style: textStyle?.copyWith(
                        color: dark ? const Color(0xFF32CD32) : Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(
                "assets/images/content/download.png",
                color: Colors.grey,
                height: 55, // Adjust the height to fit the AppBar
              ),
            ],
          )
        : titleWidget.value;
  }
}
