import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/searchbars/search_bar.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/trainer_module/features/controllers/membership_controller.dart';
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
  void initState() {
    super.initState();
    final trainerId = userController.user.value.id;
    membershipController.fetchMembershipDetails(trainerId);
    membershipController.fetchClientDetailsForTrainer(trainerId);
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

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
              SizedBox(height: 5),
            ],
          ),
        ),
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
                itemCount: membershipController.clientDetails.length,
                itemBuilder: (context, index) {
                  final client = membershipController.clientDetails[index];
                  String planExpiry = 'N/A';

                  List<Widget> membershipWidgets = [];
                  if (client.memberships != null &&
                      client.memberships.isNotEmpty) {
                    for (int membershipIndex = 0;
                        membershipIndex < client.memberships.length;
                        membershipIndex++) {
                      final membership = client.memberships[membershipIndex];
                      final endTimestamp = membership['endDate'];

                      if (endTimestamp != null && endTimestamp is Timestamp) {
                        final planExpiryDate = endTimestamp.toDate();
                        planExpiry = planExpiryDate.toLocal().toString();
                      }

                      DateTime endDateTime =
                          (endTimestamp != null && endTimestamp is Timestamp)
                              ? endTimestamp.toDate()
                              : DateTime.now();

                      membershipWidgets.add(GestureDetector(
                        onTap: () {
                          final membershipData =
                              client.memberships[membershipIndex];
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
                      ));
                    }
                  }

                  return Column(
                    children: membershipWidgets,
                  );
                },
              ),
            )
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
