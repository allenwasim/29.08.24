import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/admin_module/features/personalization/add_stage.dart';
import 'package:t_store/admin_module/features/personalization/controllers/add_level_controller.dart';
import 'package:t_store/admin_module/features/personalization/sections/Programme_management/screens/make_levels_screen.dart';

class AddProgrammeScreen extends StatelessWidget {
  AddProgrammeScreen({super.key});
  final AddLevelController addLevelController = Get.put(AddLevelController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Programme')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: addLevelController.addLevelFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Programme Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: addLevelController.titleController,
                decoration: const InputDecoration(labelText: 'Programme Title'),
                validator: (value) =>
                    value!.isEmpty ? 'Title is required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: addLevelController.bannerImageController,
                decoration:
                    const InputDecoration(labelText: 'Banner Image URL'),
                validator: (value) =>
                    value!.isEmpty ? 'Banner image URL is required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: addLevelController.stagesCountController,
                decoration:
                    const InputDecoration(labelText: 'Number of Stages'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Stages count is required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: addLevelController.estimatedDurationController,
                decoration: const InputDecoration(labelText: 'Duration'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: addLevelController.workoutDurationController,
                decoration:
                    const InputDecoration(labelText: 'Workout Duration'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: addLevelController.equipmentController,
                decoration: const InputDecoration(labelText: 'Equipment'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: addLevelController.designedForController,
                decoration: const InputDecoration(labelText: 'Designed For'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: addLevelController.overviewController,
                decoration: const InputDecoration(labelText: 'Overview'),
                maxLines: 4,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (addLevelController.addLevelFormKey.currentState!
                      .validate()) {
                    try {
                      // Call the `addProgramme` method and get the programmeId
                      String programmeId =
                          await addLevelController.addProgrammes();

                      // Navigate to the next screen and pass programmeId
                      Get.to(() => MakeLevelScreen(programmeId: programmeId));
                    } catch (e) {
                      Get.snackbar('Error', e.toString());
                    }
                  } else {
                    Get.snackbar('Validation Error',
                        'Please fill out all required fields');
                  }
                },
                child: const Text('Save Programme'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
