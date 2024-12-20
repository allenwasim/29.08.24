import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:t_store/admin_module/features/personalization/controllers/add_level_controller.dart';
import 'package:t_store/utils/validators/validation.dart';

class AddLevelScreen extends StatefulWidget {
  final String programmeId;

  const AddLevelScreen({super.key, required this.programmeId});

  @override
  _AddLevelScreenState createState() => _AddLevelScreenState();
}

class _AddLevelScreenState extends State<AddLevelScreen> {
  final _titleController = TextEditingController();
  final _subtitleController = TextEditingController();
  final List<Map<String, String>> _exercises = [];
  File? _selectedImage;

  final AddLevelController _addLevelController = Get.put(AddLevelController());

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
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
        _selectedImage == null ||
        _exercises.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    if (_exercises.any((exercise) =>
        (exercise['name']?.trim().isEmpty ?? true) ||
        (exercise['reps']?.trim().isEmpty ?? true))) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ensure all exercise fields are filled')),
      );
      return;
    }

    // Saving the level
    await _addLevelController.addLevel(
      programmeId: widget.programmeId, // Pass the programmeId here
      title: _titleController.text,
      subtitle: _subtitleController.text,
      imagePath: _selectedImage?.path ?? '',
      exercises: _exercises
          .map((exercise) => {
                "name": exercise['name']?.trim() ?? '',
                "reps": exercise['reps']?.trim() ?? '',
              })
          .toList(),
    );

    // Navigate to MakeLevelScreen or navigate back
    // Get.to(() => MakeLevelScreen()); // Navigate to MakeLevelScreen
    // OR if you want to go back to the previous screen:
    Navigator.pop(context); // Go back
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
                  return TValidator.validateEmptyText('Workout Title', value);
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
                  return TValidator.validateEmptyText(
                      'Workout Subtitle', value);
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
                  child: _selectedImage == null
                      ? const Center(child: Text('Tap to select an image'))
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.file(
                            _selectedImage!,
                            fit: BoxFit.cover,
                          ),
                        ),
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
                              return TValidator.validateEmptyText(
                                  'Exercise Name', value);
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
                              return TValidator.validateEmptyText(
                                  'Reps', value);
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
