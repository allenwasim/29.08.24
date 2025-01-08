import 'package:flutter/material.dart';
import 'package:t_store/constants/colors.dart'; // Assuming TColors is defined here
import 'package:t_store/trainer_module/features/models/trainer_model.dart';

class TrainerDetailsScreen extends StatelessWidget {
  final TrainerDetails trainer;

  const TrainerDetailsScreen({Key? key, required this.trainer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColors.trainerPrimary,
        title: Text(
          trainer.name,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 6,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture Section
            Center(
              child: ClipOval(
                child: Image.network(
                  trainer.profilePic.isNotEmpty
                      ? trainer.profilePic
                      : 'assets/images/default_trainer.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Bio Section
            _buildSectionHeader("Bio"),
            _buildSectionContent(trainer.bio),
            const SizedBox(height: 16),

            // Expertise Section
            _buildSectionHeader("Expertise"),
            _buildSectionChips(trainer.expertise),
            const SizedBox(height: 16),

            // Certifications Section
            _buildSectionHeader("Certifications"),
            _buildSectionChips(trainer.certifications),
            const SizedBox(height: 16),

            // Languages Section
            _buildSectionHeader("Languages"),
            _buildSectionChips(trainer.languages),
            const SizedBox(height: 16),

            // Experience and Availability Section
            _buildInfoRow(
                "Years of Experience", "${trainer.yearsOfExperience} years"),
            const SizedBox(height: 8),
            _buildInfoRow("Availability", trainer.availability),
          ],
        ),
      ),
    );
  }

  // Helper widget to create section headers
  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: TColors.trainerPrimary,
      ),
    );
  }

  // Helper widget for displaying section content
  Widget _buildSectionContent(String content) {
    return Text(
      content,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black87,
      ),
      textAlign: TextAlign.justify,
    );
  }

  // Helper widget for displaying a list of chips
  Widget _buildSectionChips(List<String> items) {
    return Wrap(
      spacing: 8,
      children: items
          .map((item) => Chip(
                label: Text(item),
                backgroundColor: TColors.grey,
              ))
          .toList(),
    );
  }

  // Helper widget for displaying info rows (Years of Experience, Availability)
  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
