import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/admin_module/features/personalization/add_stage.dart';
import 'package:t_store/admin_module/features/personalization/controllers/add_level_controller.dart';
import 'package:t_store/user_module/features/personalization/screens/programmes/screens/level_deatails_screen.dart';

class MakeLevelScreen extends StatefulWidget {
  final String programmeId;

  const MakeLevelScreen({super.key, required this.programmeId});

  @override
  _MakeLevelScreenState createState() => _MakeLevelScreenState();
}

class _MakeLevelScreenState extends State<MakeLevelScreen> {
  final AddLevelController addLevelController = Get.put(AddLevelController());

  @override
  Widget build(BuildContext context) {
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
        future: addLevelController
            .mapAllLevels(widget.programmeId), // Pass the programmeId
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

                    // Progress bar
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

                    // Workouts completed text
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
                    levels.isEmpty
                        ? const Center(child: Text('No levels available'))
                        : ListView.builder(
                            shrinkWrap:
                                true, // Makes the ListView take as much space as needed
                            itemCount: levels.length,
                            itemBuilder: (context, index) {
                              final level = levels[index];
                              return LevelItem(
                                level: level,
                                isDarkMode: isDarkMode,
                              );
                            },
                          ),

                    // Add Level Button
                    SizedBox(height: 20),
                    Container(
                      color: Colors.red, // Debugging background color
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(() => AddLevelScreen(
                                programmeId: widget.programmeId,
                              ));
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 25),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Add Level',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
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
