import 'package:flutter/material.dart';
import 'package:t_store/constants/colors.dart'; // Assuming TColors is defined here
import 'package:t_store/trainer_module/features/models/trainer_model.dart';

class TrainerDetailsScreen extends StatelessWidget {
  final TrainerDetails trainer;

  const TrainerDetailsScreen({Key? key, required this.trainer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [TColors.trainerPrimary, TColors.trainerPrimary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          "Trainer Details",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 8,
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
            Center(
              child: _buildProfilePicture(trainer.profilePic),
            ),
            const SizedBox(height: 16),
            Center(
              child: _buildTrainerName(trainer.name),
            ),
            const SizedBox(height: 24),
            _buildCard(
              title: "Bio",
              content: _buildSectionContent(trainer.bio),
            ),
            const SizedBox(height: 16),
            _buildCard(
              title: "Expertise",
              content: _buildSectionChips(trainer.expertise),
            ),
            const SizedBox(height: 16),
            _buildCard(
              title: "Certifications",
              content: _buildSectionChips(trainer.certifications),
            ),
            const SizedBox(height: 16),
            _buildCard(
              title: "Languages",
              content: _buildSectionChips(trainer.languages),
            ),
            const SizedBox(height: 16),
            _buildCard(
              title: "Details",
              content: Column(
                children: [
                  _buildInfoRow("Years of Experience",
                      "${trainer.yearsOfExperience} years"),
                  const SizedBox(height: 8),
                  _buildInfoRow("Availability", trainer.availability),
                  const SizedBox(height: 8),
                  _buildInfoRow("Members Trained", "${trainer.members.length}"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePicture(String profilePic) {
    return ClipOval(
      child: Material(
        elevation: 8,
        shadowColor: Colors.black26,
        child: Image.network(
          profilePic.isNotEmpty
              ? profilePic
              : 'assets/images/default_trainer.png',
          width: 120,
          height: 120,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              'assets/images/default_trainer.png',
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }

  Widget _buildTrainerName(String name) {
    return Text(
      name,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Text(
      content,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black87,
        height: 1.5,
      ),
      textAlign: TextAlign.justify,
    );
  }

  Widget _buildSectionChips(List<String> items) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items
          .map((item) => Chip(
                label: Text(item),
                backgroundColor: TColors.grey,
                labelStyle: const TextStyle(fontSize: 14),
              ))
          .toList(),
    );
  }

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

  Widget _buildCard({required String title, required Widget content}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(title),
            const SizedBox(height: 8),
            content,
          ],
        ),
      ),
    );
  }
}
