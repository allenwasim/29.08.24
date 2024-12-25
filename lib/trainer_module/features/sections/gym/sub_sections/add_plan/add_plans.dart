import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/trainer_module/data/repositories/trainer_repository.dart';

class AddPlanScreen extends StatefulWidget {
  final String trainerId;

  const AddPlanScreen({Key? key, required this.trainerId}) : super(key: key);

  @override
  _AddPlanScreenState createState() => _AddPlanScreenState();
}

class _AddPlanScreenState extends State<AddPlanScreen> {
  final _formKey = GlobalKey<FormState>();
  final TrainerRepository trainerRepository = Get.put(TrainerRepository());

  String _name = '';
  String _description = '';
  double _price = 0;
  String _duration = '';
  List<String> _workouts = [];
  bool _isAvailable = true;

  final List<String> availableWorkouts = [
    "Yoga",
    "Strength Training",
    "Cardio",
    "HIIT",
    "Pilates",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Membership Plan')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Plan Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the plan name';
                    }
                    return null;
                  },
                  onChanged: (value) => setState(() {
                    _name = value;
                  }),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                  onChanged: (value) => setState(() {
                    _description = value;
                  }),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the price';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                  onChanged: (value) => setState(() {
                    _price = double.tryParse(value) ?? 0;
                  }),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Duration'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the duration';
                    }
                    return null;
                  },
                  onChanged: (value) => setState(() {
                    _duration = value;
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Workouts Included',
                          style: TextStyle(fontSize: 16)),
                      Wrap(
                        spacing: 10,
                        children: availableWorkouts.map((workout) {
                          return ChoiceChip(
                            label: Text(workout),
                            selected: _workouts.contains(workout),
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  _workouts.add(workout);
                                } else {
                                  _workouts.remove(workout);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                SwitchListTile(
                  title: const Text('Available for new clients'),
                  value: _isAvailable,
                  onChanged: (value) {
                    setState(() {
                      _isAvailable = value;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Use the passed trainerId
                      await trainerRepository.addMembershipPlan(
                        widget.trainerId,
                        _name,
                        _description,
                        _price,
                        _duration,
                        _workouts,
                        _isAvailable,
                      );

                      Get.snackbar(
                        'Success',
                        'Membership plan added successfully!',
                        snackPosition: SnackPosition.BOTTOM,
                      );

                      // Navigate back or to another screen
                      Get.back();
                    }
                  },
                  child: const Text('Add Plan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
