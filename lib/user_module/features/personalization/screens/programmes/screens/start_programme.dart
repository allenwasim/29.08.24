import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/user_module/features/personalization/screens/programmes/screens/level_deatails_screen.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class StartProgramme extends StatelessWidget {
  const StartProgramme({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine whether the current mode is dark or light
    bool isDarkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: Stack(
        children: [
          // Main Content Scrollable ListView
          ListView(
            padding: EdgeInsets.zero,
            children: [
              // Top Image with Back Button and Title
              Stack(
                children: [
                  Container(
                    height: 400, // Adjust height as needed
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(TImages.homeimage2), // Image path
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40, // Adjust for preferred back button position
                    left: 16,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const Positioned(
                    bottom: 16,
                    left: 16,
                    child: Text(
                      'Pilates Primer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              // Main Content
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16), // Spacing under the image

                    // Details Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '2 stages',
                          style: TextStyle(
                              color: isDarkMode ? Colors.grey : Colors.black,
                              fontSize: 16),
                        ),
                        Text(
                          '2–3 weeks',
                          style: TextStyle(
                              color: isDarkMode ? Colors.grey : Colors.black,
                              fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Beginner to\nintermediate',
                          style: TextStyle(
                              color: isDarkMode ? Colors.grey : Colors.black,
                              fontSize: 10),
                        ),
                        Text(
                          '5-min – 30-min\nworkouts',
                          style: TextStyle(
                              color: isDarkMode ? Colors.grey : Colors.black,
                              fontSize: 10),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),

                    // Stage 1 Section
                    Text(
                      'Stage 1',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Your pathway to Pilates',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Unlock your potential during this introduction. Move with purpose through these functional workouts, allowing our Nike Well Collective Trainers to guide you through everything you need to make Pilates an essential part of your fitness routine.',
                      style: TextStyle(
                          color: isDarkMode ? Colors.grey : Colors.black,
                          fontSize: 16),
                    ),
                    SizedBox(height: 24),

                    // Stage 2 Section
                    Text(
                      'Stage 2',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Pilates for every purpose',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Leave no muscle untouched as you go deeper into the practical elements of Pilates in this stage. Movement is magic—our Nike Well Collective Trainers are here to help get you on the path to performing your very best, every single day.',
                      style: TextStyle(
                          color: isDarkMode ? Colors.grey : Colors.black,
                          fontSize: 16),
                    ),
                    SizedBox(height: 24),

                    // Program Information Section
                    Text(
                      'Open yourself up to the diverse world of Pilates and develop essential strength and flexibility in this self-paced programme.\n\n'
                      'New here? No problem. Stage 1 will serve as an intro and set you up to show off in Stage 2.\n\n'
                      'Already a Pilates pro? No sweat. Any workout can be as challenging as you make it—don\'t hold back!',
                      style: TextStyle(
                          color: isDarkMode ? Colors.grey : Colors.black,
                          fontSize: 16),
                    ),
                    SizedBox(height: 16),

                    // Equipment Section
                    Text(
                      'Equipment:',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'None',
                      style: TextStyle(
                          color: isDarkMode ? Colors.grey : Colors.black,
                          fontSize: 16),
                    ),
                    SizedBox(height: 16),

                    // Designed For Section
                    Text(
                      'Designed for:',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'At home',
                      style: TextStyle(
                          color: isDarkMode ? Colors.grey : Colors.black,
                          fontSize: 16),
                    ),
                    SizedBox(height: 80),
                  ],
                ),
              ),
            ],
          ),

          // Start Programme Button - Fixed to Bottom
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDarkMode ? Colors.white : Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () => Get.to(() => LevelDetailsScreen()),
                  child: Text(
                    'Start programme',
                    style: TextStyle(
                      color: isDarkMode ? Colors.black : Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
