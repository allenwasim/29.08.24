import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/searchbars/search_bar.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/trainer_module/features/controllers/membership_controller.dart';
import 'package:t_store/trainer_module/features/sections/gym/sub_sections/add_plan/add_plans.dart';
import 'package:t_store/trainer_module/features/sections/members/widgets/client_membership_card.dart';
import 'package:t_store/trainer_module/features/sections/members/widgets/client_membership_detailed_screen.dart';
import 'package:t_store/user_module/features/personalization/controllers/user_controller.dart';

class MembersScreen extends StatefulWidget {
  const MembersScreen({super.key});

  @override
  _MembersScreenState createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  final MembershipController membershipController =
      Get.put(MembershipController());
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    membershipController
        .fetchClientDetailsForTrainer(userController.user.value.id);
    membershipController.fetchMembershipDetails(userController.user.value.id);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColors.trainerPrimary,
        title: const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: [
              TSearchBar(
                backgroundColor: Colors.white,
                textColor: Colors.grey,
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
            child: OutlinedButton(
              onPressed: () {
                // Action when Add Plan button is pressed.
                Get.to(() =>
                    AddPlanScreen()); // Replace with your screen for adding a plan
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                    color: Colors
                        .white), // White border color for the outlined button
              ),
              child: Text(
                'Add +',
                style: TextStyle(
                    color: Colors
                        .white, // Make the text color white to match the AppBar theme
                    fontWeight: FontWeight.bold,
                    fontSize: 10),
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (membershipController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: TColors.trainerPrimary,
            ),
          );
        }

        if (membershipController.membershipDetails.isEmpty) {
          return Center(child: Text('No membership details available.'));
        }

        if (membershipController.clientDetails.isEmpty) {
          return Center(child: Text('No client details available.'));
        }

        final clients = membershipController.clientDetails;

        return Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDropdownButton('All Member', dark),
                _buildDropdownButton('All Plans', dark),
                _buildDropdownButton('Select Batch', dark),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: clients.length,
                itemBuilder: (context, index) {
                  final client = clients[index];
                  String planExpiry = 'N/A';

                  // Directly handle membership details
                  if (client.memberships != null &&
                      client.memberships.isNotEmpty) {
                    // Get the latest membership or process all if needed
                    final membership = client.memberships
                        .first; // assuming we're using the first membership

                    final endTimestamp = membership['endDate'];
                    if (endTimestamp != null && endTimestamp is Timestamp) {
                      final planExpiryDate = endTimestamp.toDate();
                      planExpiry = planExpiryDate.toLocal().toString();
                    }

                    DateTime endDateTime =
                        (endTimestamp != null && endTimestamp is Timestamp)
                            ? endTimestamp.toDate()
                            : DateTime.now();

                    return GestureDetector(
                      onTap: () {
                        final membershipData = membership;
                        Get.to(
                          () => ClientMembershipDetails(
                            client: client,
                            trainerId: userController.user.value.id,
                            startDate: membershipData['startDate'],
                            endDate: membershipData['endDate'],
                            membershipId: membershipData['membershipId'],
                            membership: membership,
                          ),
                        );
                      },
                      child: UserMembershipCard(
                        name: client.name,
                        mobile: client.phoneNumber,
                        email: client.email,
                        profilePic: client.profilePic,
                        planExpiry: planExpiry,
                        membershipId: membership['membershipId'],
                        daysLeft:
                            calculateRemainingDays(endDateTime).toString(),
                      ),
                    );
                  }

                  return Container(); // Return an empty container if no membership exists
                },
              ),
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.teal,
        onPressed: () {},
        icon: const Icon(Icons.rocket_launch),
        label: const Text('SMS'),
      ),
    );
  }

  int calculateRemainingDays(DateTime endDateTime) {
    final currentDate = DateTime.now();
    final difference = endDateTime.difference(currentDate);
    return difference.inDays;
  }

  Widget _buildDropdownButton(String title, bool dark) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: dark ? Colors.grey.shade800 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: dark ? Colors.grey.shade600 : Colors.grey.shade400,
          ),
        ),
        child: DropdownButton<String>(
          value: title,
          underline: const SizedBox(),
          isDense: true,
          onChanged: (value) {
            // Filter membership details based on selection
          },
          items: [
            DropdownMenuItem(
              value: title,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: dark ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
          iconSize: 16,
          iconEnabledColor: dark ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
