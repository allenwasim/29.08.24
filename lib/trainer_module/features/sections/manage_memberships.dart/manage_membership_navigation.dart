import 'package:flutter/material.dart';
import 'package:t_store/trainer_module/features/sections/manage_memberships.dart/sections/Members/members.dart';
import 'package:t_store/trainer_module/features/sections/manage_memberships.dart/sections/collection/collection.dart';
import 'package:t_store/trainer_module/features/sections/manage_memberships.dart/sections/dash_board/dashboard.dart';
import 'package:t_store/trainer_module/features/sections/manage_memberships.dart/sections/gym/gym.dart';

class ManageMembershipNavigation extends StatefulWidget {
  const ManageMembershipNavigation({super.key});

  @override
  State<ManageMembershipNavigation> createState() =>
      _ManageMembershipNavigationState();
}

class _ManageMembershipNavigationState
    extends State<ManageMembershipNavigation> {
  int selectedIndex = 0; // Default index for BottomNavigationBar

  // List of screens to display
  final List<Widget> screens = [
    MembersScreen(),
    DashboardScreen(),
    CollectionScreen(),
    GymScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex, // Tracks the selected index
        onTap: _onItemTapped, // Handles tap to navigate between screens
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        selectedFontSize: 12,
        unselectedFontSize: 10,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Members',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'Collection',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.house),
            label: 'Gym',
          ),
        ],
      ),
    );
  }
}
