import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/admin_module/features/personalization/controllers/add_level_controller.dart';
import 'package:t_store/utils/constants/image_strings.dart';

class AddLevelScreen extends StatefulWidget {
  const AddLevelScreen({super.key});

  @override
  _AddLevelScreenState createState() => _AddLevelScreenState();
}

class _AddLevelScreenState extends State<AddLevelScreen> {
  final _titleController = TextEditingController();
  final _subtitleController = TextEditingController();
  final List<Map<String, String>> _exercises = []; // Change the type here
  String? _imagePath;

  final AddLevelController _addLevelController = Get.put(AddLevelController());

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    super.dispose();
  }

  void _addExercise() {
    _exercises.add({'name': '', 'reps': ''});
    setState(() {});
  }

  void _removeExercise(int index) {
    _exercises.removeAt(index);
    setState(() {});
  }

  Future<void> _saveLevel() async {
    final form = _addLevelController.addLevelFormKey.currentState;
    if (form == null ||
        !form.validate() ||
        _imagePath == null ||
        _exercises.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    // Validate individual exercises
    if (_exercises.any((exercise) =>
        (exercise['name']?.trim().isEmpty ?? true) ||
        (exercise['reps']?.trim().isEmpty ?? true))) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ensure all exercise fields are filled')),
      );
      return;
    }

    // Call the addLevel method with all required values
    await _addLevelController.addLevel(
      title: _titleController.text,
      subtitle: _subtitleController.text,
      imagePath: _imagePath ??
          '', // Use an empty string as fallback if _imagePath is null
      exercises: _exercises
          .map((exercise) => {
                "name": exercise['name']?.trim() ?? '',
                "reps": exercise['reps']?.trim() ?? '',
              })
          .toList(),
    );
  }

  Future<void> _pickImage() async {
    // Replace with your image picker logic
    setState(() {
      _imagePath = TImages.clothIcon; // Replace with actual image picker result
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Level'),
        backgroundColor: isDarkMode ? Colors.black87 : Colors.white,
        iconTheme:
            IconThemeData(color: isDarkMode ? Colors.white : Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _addLevelController.addLevelFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Workout Title
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Workout Title',
                  labelStyle: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black),
                  border: const OutlineInputBorder(),
                ),
                style:
                    TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a workout title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Workout Subtitle
              TextFormField(
                controller: _subtitleController,
                decoration: InputDecoration(
                  labelText: 'Workout Subtitle',
                  labelStyle: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black),
                  border: const OutlineInputBorder(),
                ),
                style:
                    TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a workout subtitle';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Image Picker
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: isDarkMode ? Colors.white : Colors.black),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: _imagePath == null
                      ? const Center(child: Text('Tap to select an image'))
                      : Image.asset(_imagePath!, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 16.0),

              // Add Exercises
              Text(
                'Define Exercises:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 8.0),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _exercises.length,
                itemBuilder: (context, index) {
                  final exercise = _exercises[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        // Exercise Name
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) => exercise['name'] = value,
                            decoration: InputDecoration(
                              labelText: 'Exercise Name',
                              labelStyle: TextStyle(
                                  color:
                                      isDarkMode ? Colors.white : Colors.black),
                              border: const OutlineInputBorder(),
                            ),
                            style: TextStyle(
                                color:
                                    isDarkMode ? Colors.white : Colors.black),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter exercise name';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 8.0),

                        // Exercise Reps
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) => exercise['reps'] = value,
                            decoration: InputDecoration(
                              labelText: 'Reps',
                              labelStyle: TextStyle(
                                  color:
                                      isDarkMode ? Colors.white : Colors.black),
                              border: const OutlineInputBorder(),
                            ),
                            style: TextStyle(
                                color:
                                    isDarkMode ? Colors.white : Colors.black),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter reps';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 8.0),

                        // Remove Exercise Button
                        IconButton(
                          onPressed: () => _removeExercise(index),
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 8.0),
              TextButton.icon(
                onPressed: _addExercise,
                icon: const Icon(Icons.add),
                label: const Text('Add Exercise'),
              ),
              const SizedBox(height: 16.0),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveLevel,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDarkMode ? Colors.blueGrey : Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: const Text('Save Level'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
