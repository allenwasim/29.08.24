import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/image_strings.dart';

class Stage extends StatelessWidget {
  const Stage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current theme (light/dark mode)
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode
          ? Colors.black87
          : Colors.white, // Background color for dark mode
      appBar: AppBar(
        backgroundColor:
            Colors.transparent, // Transparent background for app bar
        elevation: 0, // Remove shadow
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: isDarkMode ? Colors.white : Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            // Stage header
            Text(
              'Stage 1: Your pathway to Pilates',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              children: List.generate(
                4,
                (index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 2.0),
                    width: 75,
                    height: 5,
                    color: isDarkMode ? Colors.grey : Colors.black12,
                  );
                },
              ),
            ),
            SizedBox(height: 10.0),
            // Workout completion progress
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Workouts completed: 0 of 4',
                  style: TextStyle(
                      color: isDarkMode ? Colors.grey : Colors.black54),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            // Featured workout banner
            Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:
                      AssetImage(TImages.homeimage1), // Replace with your asset
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(0.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'First workout',
                      style: TextStyle(color: Colors.yellow, fontSize: 14),
                    ),
                    Text(
                      'Pilates Primer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '10 minutes, beginner',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            // Workout list
            Column(
              children: [
                WorkoutItem(
                  imagePath: TImages.homeimage2,
                  title: 'Pilates Primer',
                  subtitle: '10 minutes, beginner',
                  isDarkMode: isDarkMode,
                ),
                WorkoutItem(
                  imagePath: TImages.homeimage3,
                  title: 'Core twist Pilates',
                  subtitle: '10 minutes, beginner',
                  isDarkMode: isDarkMode,
                ),
                WorkoutItem(
                  imagePath: TImages.guidanceImage1,
                  title: 'Pilates favourites',
                  subtitle: '10 minutes, intermediate',
                  isDarkMode: isDarkMode,
                ),
                WorkoutItem(
                  imagePath: TImages.guidanceImage2,
                  title: 'Slow Burn Pilates\nwith Kirsty',
                  subtitle: '15 minutes, intermediate',
                  isDarkMode: isDarkMode,
                ),
              ],
            ),
            SizedBox(height: 16.0),
            // Navigation buttons
            Center(
              child: Column(
                children: [
                  SizedBox(
                    width: 400,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to next stage
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        side: BorderSide(
                            color: isDarkMode ? Colors.white : Colors.black),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                      ),
                      child: Text(
                        'Go to next stage',
                        style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  SizedBox(
                    width: 400,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        // View programme progress
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        side: BorderSide(
                            color: isDarkMode ? Colors.white : Colors.black),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                      ),
                      child: Text(
                        'View programme progress',
                        style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 100.0),
          ],
        ),
      ),
    );
  }
}

// Workout item widget
class WorkoutItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final bool isDarkMode;

  WorkoutItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              imagePath,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                    color: isDarkMode ? Colors.grey : Colors.black54,
                    fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
