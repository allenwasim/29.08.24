import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/user_module/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/user_module/data/repositories/user/user_repositries.dart';
import 'package:t_store/user_module/features/personalization/controllers/user_controller.dart';
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
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final UserRepository userRepository = Get.put(UserRepository());
  final AuthenticationRepository authenticationRepository =
      Get.put(AuthenticationRepository());
  final UserController userController = Get.put(UserController());

  String? gender;
  String activityLevel = "Sedentary";
  String? fitnessGoal; // Changed to hold selected fitness goal.

  // Lists for height and weight options
  final List<String> heightOptions = List.generate(49, (index) {
    int feet = 5 + index ~/ 12;
    int inches = index % 12;
    return '${feet}\'${inches}"';
  });

  final List<String> weightOptions = List.generate(58, (index) {
    return '${40 + index} kg';
  });

  final List<String> fitnessGoals = [
    "Fat Loss",
    "Weight Gain",
    "Overall Fitness",
    "Muscle Building", // You can add more options here
    "Endurance",
    "Flexibility",
  ];

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
                'Height',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: heightController.text.isEmpty
                    ? null
                    : heightController.text,
                items: heightOptions.map((height) {
                  return DropdownMenuItem(
                    value: height,
                    child: Text(height),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    heightController.text = value!;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Select your height',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your height';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Weight',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: weightController.text.isEmpty
                    ? null
                    : weightController.text,
                items: weightOptions.map((weight) {
                  return DropdownMenuItem(
                    value: weight,
                    child: Text(weight),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    weightController.text = value!;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Select your weight',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your weight';
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
                'Fitness Goal',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: fitnessGoal,
                items: fitnessGoals.map((goal) {
                  return DropdownMenuItem(
                    value: goal,
                    child: Text(goal),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    fitnessGoal = value;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Select your fitness goal',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your fitness goal';
                  }
                  return null;
                },
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
                'Phone Number',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your phone number',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Address',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: addressController,
                maxLines: 3,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your address',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
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
                      // Create client details object
                      ClientDetails clientDetails = ClientDetails(
                        userId: widget.userId,
                        height: heightController.text,
                        weight: weightController.text,
                        gender: gender ??
                            'Not Specified', // Set default value if not selected
                        activityLevel: activityLevel,
                        fitnessGoal: fitnessGoal ??
                            'Not Specified', // Set default value if not selected
                        injuries: injuriesController.text,
                        memberships: [],
                        phoneNumber: phoneController.text,
                        address: addressController.text,
                        email: userController.user.value.email,
                        name: userController.user.value.fullName,
                        profilePic: userController.user.value.profilePicture,
                      );

                      // Convert ClientDetails to Map<String, dynamic> using toJson
                      userRepository
                          .saveClientDetails(
                              widget.userId, clientDetails.toJson())
                          .then((_) {
                        // Perform the screen redirection after saving details
                        authenticationRepository
                            .screenRedirect(); // Assuming screenRedirect() is a method in AuthenticationRepository

                        // Optionally, go back to the previous screen after redirection
                        Get.back();
                      });
                    }
                  },
                  child: const Text('Save Details'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
