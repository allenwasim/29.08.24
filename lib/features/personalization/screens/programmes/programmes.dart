import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/features/personalization/screens/programmes/screens/start_programme.dart';
import 'package:t_store/utils/constants/image_strings.dart';

class ProgrammesScreen extends StatelessWidget {
  const ProgrammesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Detect current theme mode
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ProgramCard(
              imageUrl: TImages.homeimage2,
              title: 'Pilates Primer',
              description:
                  'Choose progress over\nperfection with a down-to-earth take on Pilates.',
              additionalInfo: '2–3 weeks, bodyweight only',
              onTap: () {
                Get.to(() => StartProgramme());
              },
              isDarkMode: isDarkMode,
            ),
            const SizedBox(height: 16),
            ProgramCard(
              imageUrl: TImages.homeimage3,
              title: 'Strength Training\nBasics',
              description:
                  'Build a solid foundation with this full-body strength workout.',
              additionalInfo: '4–6 weeks, dumbbells required',
              onTap: () {
                Get.to(() => StartProgramme());
              },
              isDarkMode: isDarkMode,
            ),
            // Add more programs here
          ],
        ),
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
