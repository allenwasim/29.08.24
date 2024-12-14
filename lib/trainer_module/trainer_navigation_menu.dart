import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/trainer_module/features/sections/dash_board/dashboard.dart';
import 'package:t_store/trainer_module/features/sections/collection/collection.dart';
import 'package:t_store/trainer_module/features/sections/gym/gym.dart';
import 'package:t_store/trainer_module/features/sections/members/members.dart';

class TrainerNavigationMenu extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TrainerNavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final TrainerNavigationController controller =
        Get.put(TrainerNavigationController());
    final dark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = dark ? Colors.white : Colors.black;

    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(
          () => AppBar(
            backgroundColor:
                Colors.teal, // Teal color matching ManageMembershipScreen
            title: Text(
              controller.getScreenTitle(),
              style: const TextStyle(
                color: Colors.white, // Ensuring text remains white
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
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
                accountName: Text(
                  "Trainer Name",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                accountEmail: Text(
                  "trainer@example.com",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage:
                      AssetImage("assets/images/profile_placeholder.png"),
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
            const Divider(),
            buildListTile(
                context, controller, iconColor, Icons.settings, 'Settings', 4),
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
