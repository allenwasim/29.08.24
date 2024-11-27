import 'package:flutter/material.dart';

class AddLevelScreen extends StatefulWidget {
  const AddLevelScreen({super.key});

  @override
  _AddLevelScreenState createState() => _AddLevelScreenState();
}

class _AddLevelScreenState extends State<AddLevelScreen> {
  final _titleController = TextEditingController();
  final _subtitleController = TextEditingController();
  final List<Map<String, dynamic>> _exercises = [];
  String? _imagePath; // Placeholder for the image path

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

  void _saveLevel() {
    if (_titleController.text.isEmpty ||
        _subtitleController.text.isEmpty ||
        _imagePath == null ||
        _exercises.any((exercise) =>
            exercise['name'].isEmpty || exercise['reps'].isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    // Add logic to save level to database
    print("Workout Title: ${_titleController.text}");
    print("Subtitle: ${_subtitleController.text}");
    print("Image Path: $_imagePath");
    print("Exercises: $_exercises");
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Workout Title
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Workout Title',
                labelStyle:
                    TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                border: const OutlineInputBorder(),
              ),
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
            ),
            const SizedBox(height: 16.0),

            // Workout Subtitle
            TextField(
              controller: _subtitleController,
              decoration: InputDecoration(
                labelText: 'Workout Subtitle',
                labelStyle:
                    TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                border: const OutlineInputBorder(),
              ),
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
            ),
            const SizedBox(height: 16.0),

            // Image Picker
            GestureDetector(
              onTap: () {
                // Logic to pick an image (e.g., using image_picker package)
                setState(() {
                  _imagePath =
                      'assets/example_image.png'; // Replace with actual logic
                });
              },
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
              itemCount: _exercises.length,
              itemBuilder: (context, index) {
                final exercise = _exercises[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      // Exercise Name
                      Expanded(
                        child: TextField(
                          onChanged: (value) => exercise['name'] = value,
                          decoration: InputDecoration(
                            labelText: 'Exercise Name',
                            labelStyle: TextStyle(
                                color:
                                    isDarkMode ? Colors.white : Colors.black),
                            border: const OutlineInputBorder(),
                          ),
                          style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black),
                        ),
                      ),
                      const SizedBox(width: 8.0),

                      // Exercise Reps
                      Expanded(
                        child: TextField(
                          onChanged: (value) => exercise['reps'] = value,
                          decoration: InputDecoration(
                            labelText: 'Reps',
                            labelStyle: TextStyle(
                                color:
                                    isDarkMode ? Colors.white : Colors.black),
                            border: const OutlineInputBorder(),
                          ),
                          style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black),
                        ),
                      ),
                      const SizedBox(width: 8.0),

                      // Remove Exercise Button
                      IconButton(
                        onPressed: () => _removeExercise(index),
                        icon: Icon(Icons.delete, color: Colors.red),
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
    );
  }
}
