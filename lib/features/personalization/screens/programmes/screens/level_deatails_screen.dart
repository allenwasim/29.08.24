import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/admin_module/features/personalization/controllers/add_level_controller.dart';
import 'package:t_store/common/images/circular_image.dart';

class LevelDetailsScreen extends StatelessWidget {
  // Initialize the AddLevelController
  final AddLevelController addLevelController = Get.put(AddLevelController());

  @override
  Widget build(BuildContext context) {
    // Get the current theme (light/dark mode)
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black87 : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: isDarkMode ? Colors.white : Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<void>(
        future: addLevelController.mapAllLevels(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(color: Colors.red),
              ),
            );
          } else {
            return Obx(() {
              final levels = addLevelController.levels;

              if (levels.isEmpty) {
                return const Center(child: Text('No levels available'));
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16.0),
                    // Level header
                    Text(
                      'Stage 1: Your Pathway to Fitness',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20.0),

                    // Progress bar (added)
                    Row(
                      children: List.generate(
                        4,
                        (index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2.0),
                            width: 75,
                            height: 5,
                            color: isDarkMode ? Colors.grey : Colors.black12,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10.0),

                    // Workouts completed text (added)
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
                    const SizedBox(height: 20.0),

                    // Level list
                    Column(
                      children: List.generate(levels.length, (index) {
                        final level = levels[index];
                        return LevelItem(
                          level: level,
                          isDarkMode: isDarkMode,
                        );
                      }),
                    ),
                  ],
                ),
              );
            });
          }
        },
      ),
    );
  }
}

// Level item widget
class LevelItem extends StatelessWidget {
  final Map<String, dynamic> level;
  final bool isDarkMode;

  LevelItem({super.key, required this.level, required this.isDarkMode});
  final AddLevelController addLevelController = Get.put(AddLevelController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        color: isDarkMode ? Colors.black45 : Colors.white,
        child: ExpansionTile(
          title: Text(
            level['Title'] ?? 'No Title',
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            level['Subtitle'] ?? 'No Subtitle',
            style: TextStyle(color: isDarkMode ? Colors.grey : Colors.black54),
          ),
          leading: TCircularImage(
            padding: 4,
            isNetworkImage: true,
            image: level['image'],
            width: 120,
            height: 300,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Exercises:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  if (level['exercises'] != null)
                    ...List.generate(level['exercises'].length,
                        (exerciseIndex) {
                      final exercise = level['exercises'][exerciseIndex];
                      return ListTile(
                        title: Text(exercise['name'] ?? 'No name'),
                        subtitle: Text('Reps: ${exercise['reps'] ?? 'N/A'}'),
                      );
                    })
                  else
                    const Text("No exercises available"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
