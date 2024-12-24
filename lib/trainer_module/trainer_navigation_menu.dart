import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/images/circular_image.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/trainer_module/features/sections/dash_board/dashboard.dart';
import 'package:t_store/trainer_module/features/sections/collection/collection.dart';
import 'package:t_store/trainer_module/features/sections/gym/gym.dart';
import 'package:t_store/trainer_module/features/sections/members/members.dart';
import 'package:t_store/user_module/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/user_module/features/personalization/controllers/user_controller.dart';

class TrainerNavigationMenu extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TrainerNavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final TrainerNavigationController controller =
        Get.put(TrainerNavigationController());
    final dark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = dark ? Colors.white : Colors.black;
    final UserController userController = Get.put(UserController());
    final AuthenticationRepository authRepo =
        Get.put(AuthenticationRepository());

    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(
          () => AppBar(
            backgroundColor: TColors
                .trainerPrimary, // Teal color matching ManageMembershipScreen
            title: Text(
              controller.getScreenTitle(),
              style: const TextStyle(
                color: Colors.white, // Ensuring text remains white
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            iconTheme: IconThemeData(
              color: dark
                  ? Colors.black
                  : Colors.white, // Makes the drawer icon white
            ),
          ),
        ),
      ),
      body: Obx(
        () => controller.screens[controller.selectedIndex.value],
      ),
      drawer: Drawer(
        backgroundColor: dark ? Colors.black : Colors.white,
        child: ListView(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Get.to(() => const TrainerProfileScreen());
              },
              child: UserAccountsDrawerHeader(
                accountName: Obx(() {
                  return Text(
                    userController.user.value.fullName,
                    style: Theme.of(context).textTheme.headlineSmall,
                  );
                }),
                accountEmail: Obx(() {
                  return Text(
                    userController.user.value.email,
                    style: Theme.of(context).textTheme.bodyMedium,
                  );
                }),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                currentAccountPicture: Obx(
                  () => TCircularImage(
                    isNetworkImage: true,
                    image: userController.user.value.profilePicture,
                    width: 80,
                    height: 80,
                  ),
                ),
              ),
            ),
            buildListTile(context, controller, iconColor, Icons.dashboard,
                'Dashboard', 0),
            buildListTile(context, controller, iconColor, Icons.video_library,
                'Upload Tutorials', 1),
            buildListTile(
                context, controller, iconColor, Icons.people, 'Members', 2),
            buildListTile(
                context, controller, iconColor, Icons.people, 'Collection', 3),
            buildListTile(
                context, controller, iconColor, Icons.settings, 'Settings', 4),
            const Divider(),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: dark ? Colors.red : Colors.grey,
              ),
              title: Text(
                'Logout',
                style: TextStyle(
                  color: dark ? Colors.red : Colors.grey,
                ),
              ),
              onTap: () async {
                try {
                  await authRepo.logout();
                } catch (e) {
                  Get.snackbar("Logout Failed", e.toString(),
                      snackPosition: SnackPosition.BOTTOM);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  ListTile buildListTile(
      BuildContext context,
      TrainerNavigationController controller,
      Color iconColor,
      IconData icon,
      String title,
      int index) {
    return ListTile(
      leading: Obx(
        () => Icon(
          icon,
          color:
              controller.selectedIndex.value == index ? iconColor : Colors.grey,
        ),
      ),
      title: Obx(
        () => Text(
          title,
          style: TextStyle(
            color: controller.selectedIndex.value == index
                ? iconColor
                : Colors.grey,
          ),
        ),
      ),
      onTap: () {
        controller.updateSelectedIndex(index);
        Navigator.pop(context);
      },
    );
  }
}

class TrainerNavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  // Ensure this is a List<Widget>, where each widget is a screen
  final screens = [
    DashboardScreen(),
    const UploadTutorialsScreen(),
    const MembersScreen(),
    CollectionScreen(),
    const GymScreen(),
  ];

  String getScreenTitle() {
    switch (selectedIndex.value) {
      case 0:
        return 'Dashboard';
      case 1:
        return 'Upload Tutorials';
      case 2:
        return 'Members';
      case 3:
        return 'Collection';
      case 4:
        return 'Gym';
      default:
        return '';
    }
  }

  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}

class UploadTutorialsScreen extends StatelessWidget {
  const UploadTutorialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Upload Tutorials Screen',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Settings Screen',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}

class TrainerProfileScreen extends StatelessWidget {
  const TrainerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Trainer Profile Screen'),
      ),
    );
  }
}

//
