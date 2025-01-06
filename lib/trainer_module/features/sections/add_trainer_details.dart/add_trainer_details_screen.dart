import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/buttons/circular_button.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/trainer_module/features/controllers/add_trainer_details_controller.dart';
import 'package:t_store/user_module/features/personalization/controllers/user_controller.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

final UserController userController = Get.put(UserController());

class AddTrainerDetailsScreen extends StatefulWidget {
  final String userId;

  AddTrainerDetailsScreen({required this.userId});

  @override
  _AddTrainerDetailsScreenState createState() =>
      _AddTrainerDetailsScreenState();
}

class _AddTrainerDetailsScreenState extends State<AddTrainerDetailsScreen> {
  final AddTrainerController controller = Get.put(AddTrainerController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: isDarkMode ? TColors.dark : Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: TSizes.spaceBtwSections),
                _buildWelcomeSection(isDarkMode),
                const SizedBox(height: 24),
                _buildSectionTitle("Name"),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                _buildTextField(
                  controller.nameController,
                  "What name should we call you?",
                  "Name is required",
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                _buildSectionTitle("Bio"),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                _buildTextField(
                  controller.bioController,
                  "Tell us a bit about yourself.",
                  "Bio is required",
                  isBioField: true,
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                _buildSectionTitle("Expertise"),
                SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                _buildExpertiseChips(isDarkMode),
                const SizedBox(height: TSizes.spaceBtwSections),
                _buildSectionTitle("Languages"),
                SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                _buildLanguageChips(isDarkMode),
                const SizedBox(height: TSizes.spaceBtwSections),
                _buildSectionTitle("Years of Experience"),
                _buildExperienceSelection(controller),
                const SizedBox(height: 32),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(bool isDarkMode) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome text
          Text(
            "Welcome aboard, ${userController.user.value.fullName}!",
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color:
                  isDarkMode ? TColors.trainerPrimary : TColors.trainerPrimary,
            ),
          ),
          SizedBox(height: 8),
          // Subheading message
          Text(
            "You're on your way to inspiring and guiding your clients to achieve their fitness goals.",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          SizedBox(
              height: 16), // Add some spacing between the text and the image
          // Profile picture avatar
          Center(
            // Center the avatar horizontally
            child: CircleAvatar(
              radius: 60,
              backgroundImage:
                  NetworkImage(userController.user.value.profilePicture),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String labelText,
    String validationMessage, {
    bool isBioField = false,
  }) {
    return TextFormField(
      style: TextStyle(color: TColors.white),
      controller: controller,
      maxLines: isBioField ? 5 : 1,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: TColors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildExpertiseChips(bool isDarkMode) {
    return Obx(
      () => Wrap(
        spacing: 8.0,
        children: controller.availableWorkouts.entries
            .map(
              (entry) => ChoiceChip(
                label: Text(
                  entry.value,
                  style: TextStyle(
                      color: TColors.grey, fontWeight: FontWeight.bold),
                ),
                selected: controller.selectedExpertise.contains(entry.key),
                onSelected: (selected) {
                  if (selected) {
                    controller.addExpertise(entry.key);
                  } else {
                    controller.removeExpertise(entry.key);
                  }
                },
                backgroundColor:
                    isDarkMode ? Colors.grey[800] : Colors.grey[200],
                selectedColor: TColors.trainerPrimary,
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildLanguageChips(bool isDarkMode) {
    return Obx(
      () => Wrap(
        spacing: 8.0,
        children: controller.availableLanguages.entries
            .map(
              (entry) => ChoiceChip(
                label: Text(
                  entry.value,
                  style: TextStyle(
                      color: TColors.white, fontWeight: FontWeight.bold),
                ),
                selected: controller.selectedLanguages.contains(entry.key),
                onSelected: (selected) {
                  if (selected) {
                    controller.addLanguage(entry.key);
                  } else {
                    controller.removeLanguage(entry.key);
                  }
                },
                backgroundColor:
                    isDarkMode ? Colors.grey[800] : Colors.grey[200],
                selectedColor: TColors.trainerPrimary,
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildExperienceSelection(AddTrainerController controller) {
    return Column(
      children: [
        SizedBox(height: TSizes.spaceBtwInputFields),
        Row(
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
                                    controller.experienceSliderValue.value
                                        .round()
                                ? 20.0
                                : 16.0,
                            fontWeight: FontWeight.bold,
                            color: index ==
                                    controller.experienceSliderValue.value
                                        .round()
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
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: 160,
      child: TCircularButton(
        text: "Submit",
        textColor: Colors.white,
        backgroundColor: TColors.trainerPrimary,
        onTap: () {
          if (formKey.currentState?.validate() ?? false) {
            controller.saveTrainerDetails(widget.userId);
          }
        },
      ),
    );
  }
}
