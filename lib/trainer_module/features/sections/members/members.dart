import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/buttons/circular_button.dart';
import 'package:t_store/common/widgets/searchbars/search_bar.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/trainer_module/data/repositories/membership_repository.dart';
import 'package:t_store/trainer_module/features/sections/members/widgets/client_membership_card.dart';
import 'package:t_store/user_module/features/personalization/controllers/user_controller.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class MembersScreen extends StatefulWidget {
  const MembersScreen({super.key});

  @override
  _MembersScreenState createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  final UserController userController = Get.put(UserController());
  final MembershipRepository membershipRepository =
      Get.put(MembershipRepository());

  List<Map<String, dynamic>> _membershipDetails = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMembershipDetails();
  }

  Future<void> _fetchMembershipDetails() async {
    try {
      final trainerId = userController.user.value.id;
      if (trainerId == null || trainerId.isEmpty) {
        Get.snackbar('Error', 'Trainer ID is not valid.');
        return;
      }

      final membershipDetails =
          await membershipRepository.getMembershipDetailsForTrainer(trainerId);
      setState(() {
        _membershipDetails = membershipDetails;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      Get.snackbar('Error', 'Failed to fetch membership details: $e');
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: TColors.trainerPrimary,
              ),
            )
          : Column(
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
                _membershipDetails.isNotEmpty
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
                              profilePic: membership['pic'] ?? TImages.acerlogo,
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
                                    : Colors.grey.shade800,
                              ),
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
