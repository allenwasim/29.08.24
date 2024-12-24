import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/buttons/circular_button.dart';
import 'package:t_store/common/widgets/searchbars/search_bar.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class MembersScreen extends StatelessWidget {
  const MembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            TColors.trainerPrimary, // Using the trainer primary color
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
          // No Members Found Section
          Center(
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
                      color:
                          dark ? Colors.grey.shade400 : Colors.grey.shade800),
                ),
                const SizedBox(height: 10),
                const Text('OR'),
                const SizedBox(height: 10),
                TCircularButton(
                  backgroundColor: dark ? Colors.transparent : Colors.white,
                  text: "Add Members",
                  textColor: dark ? Colors.teal : Colors.teal,
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
  Widget _buildDropdownButton(String title, bool dark) {
    return Padding(
      padding: const EdgeInsets.all(4.0), // Reduced outer padding
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 8, vertical: 2), // Reduced inner padding
        decoration: BoxDecoration(
          color: dark
              ? Colors.grey.shade800
              : Colors.grey.shade200, // Background color
          borderRadius: BorderRadius.circular(6), // Smaller rounded corners
          border: Border.all(
            color: dark
                ? Colors.grey.shade600
                : Colors.grey.shade400, // Border color
          ),
        ),
        child: DropdownButton<String>(
          value: title,
          underline: const SizedBox(), // Removes the default underline
          isDense: true, // Makes the button more compact
          onChanged: (value) {},
          items: [
            DropdownMenuItem(
              value: title,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color:
                      dark ? Colors.white : Colors.black, // Dynamic text color
                ),
              ),
            ),
          ],
          iconSize: 16, // Smaller dropdown arrow
          iconEnabledColor:
              dark ? Colors.white : Colors.black, // Adjust arrow color
        ),
      ),
    );
  }
}
