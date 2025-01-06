import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/buttons/circular_button.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/user_module/features/authentication/controllers/client_details/add_client_details_controller.dart';
import 'package:t_store/user_module/features/personalization/controllers/user_controller.dart';
import 'package:t_store/utils/constants/sizes.dart';

class AddClientDetailsScreen extends StatelessWidget {
  final String userId;

  AddClientDetailsScreen({super.key, required this.userId});
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    // Instantiate the controller
    final controller = Get.put(AddClientDetailsController());

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: TSizes.spaceBtwSections),
            // Welcome Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Obx(
                () => Text(
                  'Welcome aboard,\n ${userController.user.value.firstName}!',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
            Center(
              // Center the avatar horizontally
              child: Obx(
                () => CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      NetworkImage(userController.user.value.profilePicture),
                ),
              ),
            ),
            SizedBox(height: TSizes.spaceBtwSections),

            const Text(
              'Let\'s get started by filling out your details. This will help us tailor the experience to your fitness goals.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),

            // Introduction to App Features
            const Text(
              'What you can expect from this app:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '- Access to a variety of fitness trainers.\n'
              '- Training videos to guide your journey.\n'
              '- A store for all your fitness-related products.\n'
              '- Fun and game-like features to motivate you.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),

            // Client Details Form
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
              value: controller.heightController.text.isEmpty
                  ? null
                  : controller.heightController.text,
              items: controller.heightOptions.map((height) {
                return DropdownMenuItem(
                  value: height,
                  child: Text(height),
                );
              }).toList(),
              onChanged: (value) {
                controller.heightController.text = value!;
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
              value: controller.weightController.text.isEmpty
                  ? null
                  : controller.weightController.text,
              items: controller.weightOptions.map((weight) {
                return DropdownMenuItem(
                  value: weight,
                  child: Text(weight),
                );
              }).toList(),
              onChanged: (value) {
                controller.weightController.text = value!;
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
            Obx(() {
              return Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Male'),
                      value: 'Male',
                      groupValue: controller
                          .gender.value, // Use the reactive value here
                      onChanged: (value) {
                        controller.gender.value =
                            value!; // Set new value dynamically
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Female'),
                      value: 'Female',
                      groupValue: controller
                          .gender.value, // Use the reactive value here
                      onChanged: (value) {
                        controller.gender.value =
                            value!; // Set new value dynamically
                      },
                    ),
                  ),
                ],
              );
            }),

            const SizedBox(height: 16),
            const Text(
              'Activity Level',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: controller.activityLevel,
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
                controller.activityLevel = value!;
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
              value: controller.fitnessGoal,
              items: controller.fitnessGoals.map((goal) {
                return DropdownMenuItem(
                  value: goal,
                  child: Text(goal),
                );
              }).toList(),
              onChanged: (value) {
                controller.fitnessGoal = value;
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
              controller: controller.injuriesController,
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
              controller: controller.phoneController,
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
              controller: controller.addressController,
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
              child: TCircularButton(
                onTap: () {
                  controller.saveClientDetails(userId);
                },
                text: "Save Details",
                textColor: Colors.white,
                backgroundColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
