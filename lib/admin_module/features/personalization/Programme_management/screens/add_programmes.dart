import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/admin_module/features/personalization/Programme_management/screens/programme_details.dart';

class ProgrammeInfoScreen extends StatefulWidget {
  final Function(String, String, String, String) onAddProgramme;

  const ProgrammeInfoScreen({
    super.key,
    required this.onAddProgramme,
  });

  @override
  _ProgrammeInfoScreenState createState() => _ProgrammeInfoScreenState();
}

class _ProgrammeInfoScreenState extends State<ProgrammeInfoScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController additionalInfoController =
      TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Add Programme'),
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
        titleTextStyle: TextStyle(
          color: isDarkMode ? Colors.white : Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Programme Title'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: additionalInfoController,
              decoration: const InputDecoration(labelText: 'Additional Info'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: imageUrlController,
              decoration: const InputDecoration(labelText: 'Image URL'),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the AddDetailsScreen
                  Get.to(() => AddDetailsScreen());
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(16),
                  backgroundColor: theme.primaryColor, // Button color
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
