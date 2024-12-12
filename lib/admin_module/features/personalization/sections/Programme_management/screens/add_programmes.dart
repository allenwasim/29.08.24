import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/admin_module/features/personalization/add_stage.dart';
import 'package:t_store/admin_module/features/personalization/controllers/add_level_controller.dart';

class AddProgrammeScreen extends StatefulWidget {
  const AddProgrammeScreen({super.key});

  @override
  State<AddProgrammeScreen> createState() => _AddProgrammeScreenState();
}

class _AddProgrammeScreenState extends State<AddProgrammeScreen> {
  final _formKey = GlobalKey<FormState>();

  // Programme fields
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bannerImageController = TextEditingController();
  final TextEditingController _stagesCountController = TextEditingController();
  final TextEditingController _estimatedDurationController =
      TextEditingController();
  final TextEditingController _levelsController = TextEditingController();
  final TextEditingController _workoutDurationController =
      TextEditingController();
  final TextEditingController _equipmentController = TextEditingController();
  final TextEditingController _designedForController = TextEditingController();
  final TextEditingController _overviewController = TextEditingController();

  // Stage 1 fields
  final TextEditingController _stage1TitleController = TextEditingController();
  final TextEditingController _stage1SubtitleController =
      TextEditingController();
  final TextEditingController _stage1DescriptionController =
      TextEditingController();

  // Stage 2 fields
  final TextEditingController _stage2TitleController = TextEditingController();
  final TextEditingController _stage2SubtitleController =
      TextEditingController();
  final TextEditingController _stage2DescriptionController =
      TextEditingController();
  final AddLevelController _addProgrammeController =
      Get.put(AddLevelController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Programme')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Programme Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Programme Title'),
                validator: (value) =>
                    value!.isEmpty ? 'Title is required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _bannerImageController,
                decoration:
                    const InputDecoration(labelText: 'Banner Image URL'),
                validator: (value) =>
                    value!.isEmpty ? 'Banner image URL is required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _stagesCountController,
                decoration:
                    const InputDecoration(labelText: 'Number of Stages'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Stages count is required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _estimatedDurationController,
                decoration: const InputDecoration(labelText: 'Duration'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _levelsController,
                decoration: const InputDecoration(labelText: 'Levels'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _workoutDurationController,
                decoration:
                    const InputDecoration(labelText: 'Workout Duration'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _equipmentController,
                decoration: const InputDecoration(labelText: 'Equipment'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _designedForController,
                decoration: const InputDecoration(labelText: 'Designed For'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _overviewController,
                decoration: const InputDecoration(labelText: 'Overview'),
                maxLines: 4,
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Stage 1 Details',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _stage1TitleController,
                    decoration:
                        const InputDecoration(labelText: 'Stage 1 Title'),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _stage1SubtitleController,
                    decoration:
                        const InputDecoration(labelText: 'Stage 1 Subtitle'),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _stage1DescriptionController,
                    decoration:
                        const InputDecoration(labelText: 'Stage 1 Description'),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.to(() => {});
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add Level'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Stage 2 Details',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _stage2TitleController,
                    decoration:
                        const InputDecoration(labelText: 'Stage 2 Title'),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _stage2SubtitleController,
                    decoration:
                        const InputDecoration(labelText: 'Stage 2 Subtitle'),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _stage2DescriptionController,
                    decoration:
                        const InputDecoration(labelText: 'Stage 2 Description'),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.to(() => {});
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add Level'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Form Submitted!')),
                    );
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
