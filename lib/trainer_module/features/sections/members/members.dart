import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/buttons/circular_button.dart';
import 'package:t_store/common/widgets/searchbars/search_bar.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/trainer_module/data/repositories/membership_repository.dart';
import 'package:t_store/trainer_module/features/sections/members/widgets/client_membership_card.dart';
import 'package:t_store/user_module/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/user_module/data/repositories/user/user_repositries.dart';
import 'package:t_store/user_module/features/personalization/controllers/user_controller.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class MembersScreen extends StatefulWidget {
  const MembersScreen({super.key});

  @override
  _MembersScreenState createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  final UserController userController = Get.put(UserController());
  bool _isLoading = true;
  List<Map<String, dynamic>> _membershipDetails = [];

  @override
  void initState() {
    super.initState();
    // Fetch membership details on init
    _fetchMembershipDetails();
  }

  Future<void> _fetchMembershipDetails() async {
    try {
      final membershipRepo = MembershipRepository();

      // Step 1: Fetch client IDs by trainer ID
      List<String> clientIds = await membershipRepo
          .fetchClientIdsByTrainer(userController.user.value.id);

      print("Fetched client IDs: $clientIds");

      if (clientIds.isEmpty) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Use a Set to ensure unique client IDs
      Set<String> uniqueClientIds = {};

      // Step 2: Fetch client details for each unique client ID
      List<Map<String, dynamic>> memberships = [];
      for (String clientId in clientIds) {
        if (uniqueClientIds.contains(clientId)) {
          // Skip duplicate client IDs
          continue;
        }

        uniqueClientIds.add(clientId);

        // Fetch user details for the client
        Map<String, dynamic>? userDetails =
            await UserRepository().fetchClientDetails(clientId);

        if (userDetails != null) {
          memberships.add({
            'clientId': clientId,
            'name': userDetails['name'] ?? 'Unknown',
            'mobile': userDetails['mobile'] ?? 'Not available',
            'planExpiry': userDetails['planExpiry'] ?? 'Not available',
            'email': userDetails['email'] ?? 'Not available',
          });
        } else {
          print('User details not found for clientId: $clientId');
        }
      }

      print("Final membership details (unique): $memberships");

      setState(() {
        _membershipDetails = memberships;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching membership details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

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
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Filters
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildDropdownButton('All Member', dark),
              _buildDropdownButton('All Plans', dark),
              _buildDropdownButton('Select Batch', dark),
            ],
          ),
          const SizedBox(height: 20),
          // Display fetched memberships
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _membershipDetails.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: _membershipDetails.length,
                        itemBuilder: (context, index) {
                          final membership = _membershipDetails[index];
                          return UserMembershipCard(
                            name: membership['name'] ?? 'Unknown',
                            mobile: membership['mobile'] ?? 'Not available',
                            planExpiry:
                                membership['planExpiry'] ?? 'Not available',
                            email: membership['email'] ?? 'Not available',
                            membershipId:
                                membership['membershipId'] ?? 'Not available',
                          );
                        },
                      ),
                    )
                  : Center(
                      child: Column(
                        children: [
                          Text(
                            'No Members found',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: dark ? Colors.white : Colors.black,
                            ),
                          ),
                          Text(
                            'Start Adding Member Click Top + Icon',
                            style: TextStyle(
                                color: dark
                                    ? Colors.grey.shade400
                                    : Colors.grey.shade800),
                          ),
                          const SizedBox(height: 10),
                          const Text('OR'),
                          const SizedBox(height: 10),
                          TCircularButton(
                            backgroundColor:
                                dark ? Colors.transparent : Colors.white,
                            text: "Add Members",
                            textColor: dark ? Colors.teal : Colors.teal,
                          ),
                        ],
                      ),
                    ),
        ],
      ),
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
          onChanged: (value) {},
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
