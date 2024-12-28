import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/user_module/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/user_module/data/repositories/user/user_repositries.dart';
import 'package:t_store/user_module/features/personalization/models/client_model.dart';

class AddClientDetailsScreen extends StatefulWidget {
  final String userId; // User ID passed as an argument

  const AddClientDetailsScreen({Key? key, required this.userId})
      : super(key: key);

  @override
  State<AddClientDetailsScreen> createState() => _AddClientDetailsScreenState();
}

class _AddClientDetailsScreenState extends State<AddClientDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController injuriesController = TextEditingController();
  final TextEditingController fitnessGoalController = TextEditingController();
  final UserRepository userRepository = Get.put(UserRepository());
  final AuthenticationRepository authenticationRepository =
      Get.put(AuthenticationRepository());

  String? gender;
  String activityLevel = "Sedentary";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Let us know more about you!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Height (in cm)',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your height',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your height';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Weight (in kg)',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your weight',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your weight';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Gender',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Male'),
                      value: 'Male',
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Female'),
                      value: 'Female',
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Activity Level',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: activityLevel,
                items: const [
                  DropdownMenuItem(
                    value: "Sedentary",
                    child: Text("Sedentary"),
                  ),
                  DropdownMenuItem(
                    value: "Lightly Active",
                    child: Text("Lightly Active"),
                  ),
                  DropdownMenuItem(
                    value: "Moderately Active",
                    child: Text("Moderately Active"),
                  ),
                  DropdownMenuItem(
                    value: "Very Active",
                    child: Text("Very Active"),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    activityLevel = value!;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Injuries (if any)',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: injuriesController,
                maxLines: 3,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter any injuries or leave blank if none',
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Fitness Goal',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: fitnessGoalController,
                maxLines: 3,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your fitness goal',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your fitness goal';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ClientDetails clientDetails = ClientDetails(
                        userId: widget.userId,
                        height: heightController.text,
                        weight: weightController.text,
                        gender: gender ?? 'Not Specified',
                        activityLevel: activityLevel,
                        injuries: injuriesController.text,
                        fitnessGoal: fitnessGoalController.text,
                        memberships: [],
                      );

                      // Convert ClientDetails to Map<String, dynamic> using toJson
                      userRepository
                          .saveClientDetails(widget.userId,
                              clientDetails.toJson()) // Pass as a Map
                          .then((_) {
                        // Navigate back after saving the client details
                        Get.snackbar(
                            "Success", "Client details saved successfully!");
                        authenticationRepository.screenRedirect();
                      }).catchError((error) {
                        Get.snackbar(
                            "Error", "Failed to save client details: $error");
                      });
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
