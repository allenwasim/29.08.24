import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/admin_module/features/personalization/Programme_management/screens/programme_management.dart';
import 'package:t_store/admin_module/features/personalization/add_stage.dart';

// Define a controller to manage navigation
class AdminNavigationController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  final List<Widget> screens = [
    DashboardScreen(),
    UserManagementScreen(),
    ContentManagementScreen(),
    StoreManagementScreen(),
    MembershipManagementScreen(),
    AdminProgrammesScreen(),
    TrainingManagementScreen(),
    AnalyticsScreen(),
    SettingsScreen(),
  ];

  final List<String> titles = [
    'Dashboard',
    'User Management',
    'Content Management',
    'Store Management',
    'Membership Management',
    'Programme Management',
    'Training Management',
    'Analytics & Reports',
    'Settings',
  ];
}

class AdminNavigationScreen extends StatelessWidget {
  final AdminNavigationController controller =
      Get.put(AdminNavigationController());

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title:
            Obx(() => Text(controller.titles[controller.selectedIndex.value])),
        backgroundColor: isDark ? Colors.black : Colors.blue,
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[800] : Colors.blue,
              ),
              child: Center(
                child: Text(
                  'Admin Panel',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            buildDrawerItem(
              icon: Icons.dashboard,
              text: 'Dashboard',
              index: 0,
              context: context,
            ),
            buildDrawerItem(
              icon: Icons.people,
              text: 'User Management',
              index: 1,
              context: context,
            ),
            buildDrawerItem(
              icon: Icons.library_books,
              text: 'Content Management',
              index: 2,
              context: context,
            ),
            buildDrawerItem(
              icon: Icons.store,
              text: 'Store Management',
              index: 3,
              context: context,
            ),
            buildDrawerItem(
              icon: Icons.card_membership,
              text: 'Membership Management',
              index: 4,
              context: context,
            ),
            buildDrawerItem(
              icon: Icons.timeline,
              text: 'Programme Management',
              index: 5,
              context: context,
            ),
            buildDrawerItem(
              icon: Icons.fitness_center,
              text: 'Training Management',
              index: 6,
              context: context,
            ),
            buildDrawerItem(
              icon: Icons.bar_chart,
              text: 'Analytics & Reports',
              index: 7,
              context: context,
            ),
            buildDrawerItem(
              icon: Icons.settings,
              text: 'Settings',
              index: 8,
              context: context,
            ),
          ],
        ),
      ),
    );
  }

  ListTile buildDrawerItem({
    required IconData icon,
    required String text,
    required int index,
    required BuildContext context,
  }) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return ListTile(
      leading: Obx(() => Icon(
            icon,
            color: controller.selectedIndex.value == index
                ? Colors.blue
                : (isDark ? Colors.white : Colors.grey),
          )),
      title: Obx(() => Text(
            text,
            style: TextStyle(
              color: controller.selectedIndex.value == index
                  ? Colors.blue
                  : (isDark ? Colors.white : Colors.grey),
            ),
          )),
      onTap: () {
        controller.selectedIndex.value = index;
        Navigator.pop(context); // Close the drawer
      },
    );
  }
}

// Placeholder screens for each module
class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Dashboard Screen'));
  }
}

class UserManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('User Management Screen'));
  }
}

class ContentManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Content Management Screen'));
  }
}

class StoreManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Store Management Screen'));
  }
}

class MembershipManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Membership Management Screen'));
  }
}

class TrainingManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Training Management Screen'));
  }
}

class AnalyticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Analytics Screen'));
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Settings Screen'));
  }
}
