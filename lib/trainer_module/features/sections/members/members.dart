import 'package:flutter/material.dart';

class MembersScreen extends StatelessWidget {
  const MembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for "Mobile"',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
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
                ElevatedButton(
                  onPressed: null,
                  child: Text('Add Member'),
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
