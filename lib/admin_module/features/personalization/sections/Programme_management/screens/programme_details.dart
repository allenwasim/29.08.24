import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/admin_module/features/personalization/sections/Programme_management/screens/make_levels_screen.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class AddDetailsScreen extends StatelessWidget {
  const AddDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine whether the current mode is dark or light
    bool isDarkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
        title: Text(
          'Add Programme',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Programme Title
            TextField(
              decoration: InputDecoration(
                labelText: 'Programme Title',
                labelStyle: TextStyle(
                  color: isDarkMode ? Colors.grey : Colors.black,
                ),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Programme Description
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(
                  color: isDarkMode ? Colors.grey : Colors.black,
                ),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Duration
            TextField(
              decoration: InputDecoration(
                labelText: 'Duration (e.g., 2-3 weeks)',
                labelStyle: TextStyle(
                  color: isDarkMode ? Colors.grey : Colors.black,
                ),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Number of Stages
            TextField(
              decoration: InputDecoration(
                labelText: 'Number of Stages',
                labelStyle: TextStyle(
                  color: isDarkMode ? Colors.grey : Colors.black,
                ),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            // Equipment Required
            TextField(
              decoration: InputDecoration(
                labelText: 'Equipment Required',
                labelStyle: TextStyle(
                  color: isDarkMode ? Colors.grey : Colors.black,
                ),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Designed For
            TextField(
              decoration: InputDecoration(
                labelText: 'Designed For (e.g., At Home, Gym)',
                labelStyle: TextStyle(
                  color: isDarkMode ? Colors.grey : Colors.black,
                ),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 100),

            // Next Button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the AddDetailsScreen
                  Get.to(() => MakeLevelScreen());
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(16),
                ),
                child: const Icon(Icons.chevron_right,
                    size: 32, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
