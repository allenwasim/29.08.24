import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/searchbars/search_bar.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/trainer_module/features/controllers/membership_controller.dart';
import 'package:t_store/trainer_module/features/sections/members/widgets/client_membership_card.dart';
import 'package:t_store/user_module/features/personalization/controllers/user_controller.dart';

class MembersScreen extends StatefulWidget {
  const MembersScreen({super.key});

  @override
  _MembersScreenState createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  final MembershipController membershipController =
      Get.put(MembershipController());

  @override
  void initState() {
    super.initState();
    final trainerId = UserController.instance.user.value.id;
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
                    final membership =
                        membershipController.membershipDetails[index];

                    // Check the raw data returned from Firestore

                    // Check if the client has memberships and extract data
                    String planExpiry =
                        'N/A'; // Default value if no memberships found

                    if (client.memberships != null &&
                        client.memberships.isNotEmpty) {
                      // Access the first membership (or iterate if needed)
                      final timestamp = client.memberships[0]['endDate'];

                      // Ensure timestamp is not null and is an instance of Timestamp
                      if (timestamp != null && timestamp is Timestamp) {
                        // Convert the Firestore Timestamp to DateTime
                        final planExpiryDate = timestamp
                            .toDate(); // Use .toDate() to convert to DateTime
                        planExpiry = planExpiryDate
                            .toLocal()
                            .toString(); // Convert to local time and string
                      } else {
                        planExpiry = 'N/A';
                      }
                    }

                    return GestureDetector(
                      onTap: () {
                        // Navigation logic goes here
                      },
                      child: UserMembershipCard(
                        name: client.name, // Display client name
                        mobile:
                            client.phoneNumber, // Display client phone number
                        email: client.email, // Display client email
                        profilePic:
                            client.profilePic, // Display the URL if available
                        planExpiry: planExpiry, // Display the plan expiry date
                        membershipId:
                            membership.membershipId, // Display membership ID
                      ),
                    );
                  }),
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
