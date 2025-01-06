import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/buttons/circular_button.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/trainer_module/features/controllers/add_trainer_details_controller.dart';
import 'package:t_store/user_module/features/personalization/controllers/user_controller.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class AddTrainerDetailsScreen extends StatefulWidget {
  final String userId;

  AddTrainerDetailsScreen({required this.userId});

  @override
  _AddTrainerDetailsScreenState createState() =>
      _AddTrainerDetailsScreenState();
}

final UserController userController = Get.put(UserController());

class _AddTrainerDetailsScreenState extends State<AddTrainerDetailsScreen> {
  final AddTrainerController controller =
      Get.put(AddTrainerController(userId: userController.user.value.id));

  // Add a GlobalKey for form validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome Section
                    _buildWelcomeSection(dark),
                    const SizedBox(height: 32),

                    // Trainer Name Field
                    _buildTextField(controller.nameController,
                        "What name should we call you?", "Name is required"),

                    const SizedBox(height: 16),

                    // Bio Field
                    _buildTextField(controller.bioController,
                        "Tell us a bit about yourself.", "Bio is required",
                        isBioField: true),

                    const SizedBox(height: 16),

                    // Expertise Section
                    _buildSectionTitle("Expertise"),
                    _buildExpertiseChips(dark),

                    const SizedBox(height: 16),

                    // Languages Section
                    _buildSectionTitle("Languages"),
                    _buildLanguageChips(dark),

                    const SizedBox(height: 16),

                    // Years of Experience Section
                    _buildSectionTitle("Years of Experience"),
                    _buildExperienceSelection(controller),

                    const SizedBox(height: 32),

                    // Submit Button
                    _buildSubmitButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Welcome Section
  Widget _buildWelcomeSection(bool dark) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Text(
        "Welcome, ${userController.user.value.fullName}!",
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: dark ? TColors.trainerPrimary : TColors.trainerPrimary,
        ),
      ),
    );
  }

  // Section title
  Widget _buildSectionTitle(String title) {
    final dark = THelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: dark ? TColors.trainerPrimary : TColors.trainerPrimary,
        ),
      ),
    );
  }

  // Improved experience selection
  Widget _buildExperienceSelection(AddTrainerController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 8),
        Container(
          height: 80,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.black,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 6,
                spreadRadius: 1,
              )
            ],
          ),
          child: ListWheelScrollView.useDelegate(
            itemExtent: 40,
            diameterRatio: 1.2,
            onSelectedItemChanged: (index) {
              controller.updateExperience(index);
            },
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, index) {
                return Center(
                  child: Obx(
                    () => AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      style: TextStyle(
                        fontSize: index ==
                                controller.experienceSliderValue.value.round()
                            ? 20.0
                            : 16.0,
                        fontWeight: FontWeight.bold,
                        color: index ==
                                controller.experienceSliderValue.value.round()
                            ? TColors.primary
                            : Colors.white,
                      ),
                      child: Text("$index years"),
                    ),
                  ),
                );
              },
              childCount: 51,
            ),
          ),
        ),
      ],
    );
  }

  // Submit button
  Widget _buildSubmitButton() {
    return SizedBox(
      width: 200,
      child: TCircularButton(
        text: "Submit",
        textColor: Colors.white,
        backgroundColor: TColors.trainerPrimary,
        onTap: () {
          if (formKey.currentState?.validate() ?? false) {
            _validateAndSubmitForm();
          }
        },
      ),
    );
  }

  // Validate and submit form
  void _validateAndSubmitForm() {
    if (controller.selectedExpertise.isEmpty) {
      Get.snackbar("Validation Error", "Please select at least one expertise.");
      return;
    }

    if (controller.selectedLanguages.isEmpty) {
      Get.snackbar("Validation Error", "Please select at least one language.");
      return;
    }

    if (controller.experienceSliderValue.value == null ||
        controller.experienceSliderValue.value == 0) {
      Get.snackbar("Validation Error", "Please select years of experience.");
      return;
    }

    print("Form is valid, submitting...");
    controller.submitForm();
  }

  // Text field with validation
  Widget _buildTextField(TextEditingController controller, String labelText,
      String validationMessage,
      {bool isBioField = false}) {
    final dark = THelperFunctions.isDarkMode(context);

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: dark ? Colors.grey : Colors.black,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: dark ? Colors.white : Colors.grey,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validationMessage;
        }
        return null;
      },
      maxLines: isBioField ? 5 : 1,
      keyboardType: isBioField ? TextInputType.multiline : TextInputType.text,
    );
  }

  // Choice chips for expertise
  Widget _buildExpertiseChips(bool dark) {
    return Obx(
      () => Wrap(
        spacing: 8.0,
        children: controller.availableWorkouts.entries
            .map(
              (entry) => ChoiceChip(
                label: Text(entry.value),
                selected: controller.selectedExpertise.contains(entry.key),
                onSelected: (selected) {
                  selected
                      ? controller.addExpertise(entry.key)
                      : controller.removeExpertise(entry.key);
                },
                backgroundColor: dark ? Colors.grey[800] : Colors.grey[200],
                selectedColor: TColors.trainerPrimary,
                labelStyle:
                    TextStyle(color: dark ? Colors.white : Colors.black),
              ),
            )
            .toList(),
      ),
    );
  }

  // Choice chips for languages
  Widget _buildLanguageChips(bool dark) {
    return Obx(
      () => Wrap(
        spacing: 8.0,
        children: controller.availableLanguages.entries
            .map(
              (entry) => ChoiceChip(
                label: Text(entry.value),
                selected: controller.selectedLanguages.contains(entry.key),
                onSelected: (selected) {
                  selected
                      ? controller.addLanguage(entry.key)
                      : controller.removeLanguage(entry.key);
                },
                backgroundColor: dark ? Colors.grey[800] : Colors.grey[200],
                selectedColor: TColors.trainerPrimary,
                labelStyle:
                    TextStyle(color: dark ? Colors.white : Colors.black),
              ),
            )
            .toList(),
      ),
    );
  }
}
