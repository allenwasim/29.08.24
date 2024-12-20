import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/buttons/circular_button.dart';
import 'package:t_store/common/widgets/searchbars/search_bar.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class MembersScreen extends StatelessWidget {
  const MembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            TColors.trainerPrimary, // Using the trainer primary color
        title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
                child: Column(
              children: [
                TSearchBar(
                  backgroundColor: Colors.white,
                  textColor: Colors.grey,
                ),
                SizedBox(
                  height: 5,
                )
              ],
            ))),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Filters
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildDropdownButton('All Member'),
              _buildDropdownButton('All Plans'),
              _buildDropdownButton('Select Batch'),
            ],
          ),
          const SizedBox(height: 20),
          // No Members Found Section
          const Center(
            child: Column(
              children: [
                Text(
                  'No Members found',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text('Start Adding Member Click Top + Icon'),
                SizedBox(height: 10),
                Text('OR'),
                SizedBox(height: 10),
                TCircularButton(
                  text: "Add Members",
                  textColor: Colors.teal,
                ),
              ],
            ),
          ),
        ],
      ),
      // Floating Button
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.teal,
        onPressed: () {},
        icon: const Icon(Icons.rocket_launch),
        label: const Text('SMS'),
      ),
    );
  }

  // Reusable Dropdown Button Widget
  Widget _buildDropdownButton(String title) {
    return DropdownButton<String>(
      value: title,
      underline: const SizedBox(),
      onChanged: (value) {},
      items: [DropdownMenuItem(value: title, child: Text(title))],
    );
  }
}
