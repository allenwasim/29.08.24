import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/trainer_module/features/models/trainer_model.dart';
import 'package:t_store/user_module/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/user_module/features/personalization/models/user_model.dart'; // Import your UserModel

class AddTrainerDetailsScreen extends StatefulWidget {
  final String userId; // User ID to associate the trainer details with

  AddTrainerDetailsScreen({required this.userId});

  @override
  _AddTrainerDetailsScreenState createState() =>
      _AddTrainerDetailsScreenState();
}

class _AddTrainerDetailsScreenState extends State<AddTrainerDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bioController = TextEditingController();
  final _expertiseController = TextEditingController();
  final _yearsOfExperienceController = TextEditingController();
  final _ratingController = TextEditingController();
  final _availabilityController = TextEditingController();
  final _certificationsController = TextEditingController();
  final _languagesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Trainer Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _bioController,
                  decoration: InputDecoration(labelText: 'Bio'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a bio';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16), // Added space between input fields
                TextFormField(
                  controller: _expertiseController,
                  decoration: InputDecoration(labelText: 'Expertise'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your expertise';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16), // Added space between input fields
                TextFormField(
                  controller: _yearsOfExperienceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Years of Experience'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter years of experience';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16), // Added space between input fields
                TextFormField(
                  controller: _ratingController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(labelText: 'Rating'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a rating';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16), // Added space between input fields
                TextFormField(
                  controller: _availabilityController,
                  decoration: InputDecoration(labelText: 'Availability'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter availability status';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16), // Added space between input fields
                TextFormField(
                  controller: _certificationsController,
                  decoration: InputDecoration(
                      labelText: 'Certifications (comma separated)'),
                ),
                SizedBox(height: 16), // Added space between input fields
                TextFormField(
                  controller: _languagesController,
                  decoration:
                      InputDecoration(labelText: 'Languages (comma separated)'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16), // Padding
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12), // Rounded corners
                    ),
                    textStyle: TextStyle(
                      fontSize: 16, // Larger font size for text
                      fontWeight: FontWeight.bold, // Bold text
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

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Create the trainer details object
      final trainerDetails = TrainerDetails(
        trainerId: widget.userId,
        bio: _bioController.text,
        expertise: _expertiseController.text,
        yearsOfExperience: int.tryParse(_yearsOfExperienceController.text) ?? 0,
        rating: double.tryParse(_ratingController.text) ?? 0.0,
        certifications: _certificationsController.text.split(','),
        languages: _languagesController.text.split(','),
        availability: _availabilityController.text,
      );

      try {
        // Create the UserModel instance using the provided userId
        final userModel = await UserModel.fromSnapshot(
          await FirebaseFirestore.instance
              .collection('Profiles')
              .doc(widget.userId)
              .get(),
        );

        // Save the trainer details to Firestore under the user
        await userModel.saveTrainerDetails(trainerDetails);

        // Redirect after saving the trainer details
        AuthenticationRepository.instance
            .screenRedirect(); // Call screenRedirect here

        // Navigate back after saving the trainer details
        Navigator.pop(context);
      } catch (e) {
        // Handle any errors during the process
        print("Error while saving trainer details: $e");
      }
    }
  }
}
