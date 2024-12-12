import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/admin_module/features/personalization/sections/Programme_management/screens/add_programmes.dart';
import 'package:t_store/utils/constants/image_strings.dart';

class AdminProgrammesScreen extends StatefulWidget {
  const AdminProgrammesScreen({super.key});

  @override
  _AdminProgrammesScreenState createState() => _AdminProgrammesScreenState();
}

class _AdminProgrammesScreenState extends State<AdminProgrammesScreen> {
  final List<Map<String, String>> programmes = [
    {
      'imageUrl': TImages.homeimage2,
      'title': 'Pilates Primer',
      'description':
          'Choose progress over\nperfection with a down-to-earth take on Pilates.',
      'additionalInfo': '2–3 weeks, bodyweight only',
    },
    {
      'imageUrl': TImages.homeimage3,
      'title': 'Strength Training\nBasics',
      'description':
          'Build a solid foundation with this full-body strength workout.',
      'additionalInfo': '4–6 weeks, dumbbells required',
    },
  ];

  void _addProgramme(String title, String description, String additionalInfo,
      String imageUrl) {
    setState(() {
      programmes.add({
        'imageUrl': imageUrl,
        'title': title,
        'description': description,
        'additionalInfo': additionalInfo,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Admin Programmes'),
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        iconTheme:
            IconThemeData(color: isDarkMode ? Colors.white : Colors.black),
        titleTextStyle: TextStyle(
          color: isDarkMode ? Colors.white : Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: programmes.length,
          itemBuilder: (context, index) {
            final programme = programmes[index];
            return Column(
              children: [
                ProgramCard(
                  imageUrl: programme['imageUrl']!,
                  title: programme['title']!,
                  description: programme['description']!,
                  additionalInfo: programme['additionalInfo']!,
                  onTap: () {
                    // Add functionality for tapping on a programme (edit/delete/etc.)
                  },
                  isDarkMode: isDarkMode,
                ),
                const SizedBox(height: 16),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddProgrammeScreen());
        },
        child: const Icon(Icons.add),
        backgroundColor: isDarkMode ? Colors.green[400] : Colors.green,
      ),
    );
  }
}

class ProgramCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String additionalInfo;
  final VoidCallback onTap;
  final bool isDarkMode;

  const ProgramCard({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.additionalInfo,
    required this.onTap,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: isDarkMode ? Colors.black : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(0)),
              child: Image.asset(
                imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    additionalInfo,
                    style: TextStyle(
                      color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
