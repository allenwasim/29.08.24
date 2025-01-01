import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/trainer_module/features/controllers/add_trainer_details_controller.dart';

class AddTrainerDetailsScreen extends StatelessWidget {
  final String userId;

  AddTrainerDetailsScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    final AddTrainerController controller =
        Get.put(AddTrainerController(userId: userId));

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Trainer Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(controller.nameController, "Trainer Name",
                    "Please enter a trainer name"),
                SizedBox(height: 16),
                _buildTextField(
                    controller.bioController, "Bio", "Please enter a bio"),
                SizedBox(height: 16),
                _buildTextField(controller.expertiseController, "Expertise",
                    "Please enter your expertise"),
                SizedBox(height: 16),
                _buildTextField(controller.yearsOfExperienceController,
                    "Years of Experience", "Please enter years of experience",
                    keyboardType: TextInputType.number),
                SizedBox(height: 16),
                _buildTextField(controller.ratingController, "Rating",
                    "Please enter a rating",
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true)),
                SizedBox(height: 16),
                _buildTextField(controller.availabilityController,
                    "Availability", "Please enter availability status"),
                SizedBox(height: 16),
                _buildTextField(controller.certificationsController,
                    "Certifications (comma separated)", null),
                SizedBox(height: 16),
                _buildTextField(controller.languagesController,
                    "Languages (comma separated)", null),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: controller.submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: Text("Submit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    String? validationMessage, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(labelText: label),
      validator: validationMessage != null
          ? (value) {
              if (value == null || value.isEmpty) {
                return validationMessage;
              }
              return null;
            }
          : null,
    );
  }
}
