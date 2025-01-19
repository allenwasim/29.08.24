import 'package:flutter/material.dart';
import 'package:t_store/trainer_module/features/sections/add_trainer_details/add_trainer_details_screen.dart';
import 'package:t_store/trainer_module/features/sections/dash_board/widgets/dashboad_card.dart';
import 'package:get/get.dart';
import 'package:t_store/trainer_module/features/controllers/collection_controller.dart';
import 'package:t_store/trainer_module/features/controllers/member_controller.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access CollectionController to get collection data
    final CollectionController collectionController =
        Get.put(CollectionController());

    // Access MemberController to get member data
    final MemberController memberController = Get.put(MemberController());

    // Fetch total collection and member details when the screen is initialized
    collectionController.fetchTotalCollection();
    collectionController.fetchTodaysCollection();

    memberController.fetchActiveAndExpiredMembers(userController
        .user.value.id); // Ensure a valid trainerId is passed here if required.

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Obx(() {
          return GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1.5,
            children: [
              DashboardCard(
                title: 'Expired (1-3 days)',
                icon: Icons.person_remove_alt_1,
                iconColor: Colors.teal,
                value: memberController.expired1To3Days.value
                    .toString(), // Logic for this can be implemented later
              ),
              DashboardCard(
                title: 'Expired (4-7 days)',
                icon: Icons.person_remove_alt_1,
                iconColor: Colors.teal,
                value: memberController.expired4To7Days.value
                    .toString(), // Logic for this can be implemented later
              ),
              DashboardCard(
                title: 'Expired (8-15 days)',
                icon: Icons.person_remove_alt_1,
                iconColor: Colors.teal,
                value: memberController.expired8To15Days.value
                    .toString(), // Logic for this can be implemented later
              ),
              DashboardCard(
                title: 'Expiry Today',
                icon: Icons.person_remove_alt_1,
                iconColor: Colors.teal,
                value: memberController.expiringToday.value
                    .toString(), // Logic for this can be implemented later
              ),
              DashboardCard(
                title: 'Today Collection',
                icon: Icons.attach_money,
                iconColor: Colors.green,
                value: collectionController.todaysCollection.value
                    .toString(), // Display today's collection
              ),
              DashboardCard(
                title: 'Total Collection',
                icon: Icons.attach_money,
                iconColor: Colors.green,
                value: collectionController.totalCollection.value
                    .toString(), // Display total collection
              ),
              DashboardCard(
                title: 'Total Members',
                icon: Icons.groups,
                iconColor: Colors.teal,
                value: (memberController.activeMembers.value +
                        memberController.expiredMembers.value)
                    .toString(), // Total members
              ),
              DashboardCard(
                title: 'Active Members',
                icon: Icons.groups,
                iconColor: Colors.green,
                value: memberController.activeMembers.value
                    .toString(), // Display active members
              ),
              DashboardCard(
                title: 'Expired Members',
                icon: Icons.person_remove_alt_1,
                iconColor: Colors.red,
                value: memberController.expiredMembers.value
                    .toString(), // Display expired members
              ),
            ],
          );
        }),
      ),
    );
  }
}
