import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:t_store/common/widgets/buttons/circular_button.dart';
import 'package:t_store/trainer_module/features/controllers/membership_controller.dart';
import 'package:t_store/trainer_module/features/models/membership_model.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/trainer_module/features/models/trainer_model.dart';
import 'package:t_store/trainer_module/features/sections/add_trainer_details.dart/add_trainer_details_screen.dart';
import 'package:t_store/user_module/features/personalization/controllers/user_controller.dart';
import 'package:t_store/utils/constants/image_strings.dart';

class AvailableMembershipDetailsScreen extends StatelessWidget {
  final MembershipModel membership;
  final TrainerDetails trainerDetails;
  final MembershipController membershipController =
      Get.put(MembershipController());

  AvailableMembershipDetailsScreen({
    Key? key,
    required this.membership,
    required this.trainerDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    final List<String> trainerExpertise = trainerDetails.expertise ?? [];
    final String trainerBio = trainerDetails.bio ?? 'No bio available';
    final int trainerYearsOfExperience = trainerDetails.yearsOfExperience ?? 0;
    final double trainerRating = trainerDetails.rating ?? 0.0;
    final List<String> trainerCertifications =
        trainerDetails.certifications ?? [];
    final List<String> trainerLanguages = trainerDetails.languages ?? [];
    final String trainerAvailability =
        trainerDetails.availability ?? 'Not available';
    final String trainerProfilePic =
        trainerDetails.profilePic ?? TImages.userProfileImage1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Membership Details'),
        backgroundColor: dark ? TColors.trainerPrimary : TColors.trainerPrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Trainer Details Section
              Text(
                'Trainer Details',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipOval(
                    child: Image.network(
                      trainerProfilePic,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow('Name', trainerDetails.name),
                        const SizedBox(height: 4),
                        _buildDetailRow(
                            'Expertise', trainerExpertise.join(", ")),
                        _buildDetailRow('Rating', '$trainerRating ⭐'),
                        const SizedBox(height: 8),
                        Card(
                          elevation: 4.0,
                          color: dark ? Colors.black45 : Colors.grey[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              trainerBio,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: dark ? Colors.white : Colors.black54,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Certifications and Languages Section
              const SizedBox(height: 8),
              _buildListRow('Certifications', trainerCertifications),
              const SizedBox(height: 8),
              _buildListRow('Languages', trainerLanguages),
              const SizedBox(height: 8),

              const SizedBox(height: 20),

              // Membership Plan Section
              Text(
                "Membership Details",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: _buildDetailRow('Plan', membership.planName),
              ),

              const SizedBox(height: 12),
              Center(
                child: Card(
                  elevation: 4.0,
                  color: dark ? Colors.black45 : Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      membership.description,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: dark ? Colors.white : Colors.black54,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Price & Duration
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDetailColumn('Price', membership.formattedPrice),
                  _buildDetailColumn(
                      'Duration', membership.duration.toString()),
                ],
              ),
              const SizedBox(height: 16),

              // Training Includes Section
              _buildSectionTitle('Training Includes:'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: membership.workouts.map((workout) {
                  return Chip(
                    label: Text(workout),
                    backgroundColor:
                        dark ? Colors.white10 : Colors.green.shade100,
                    labelStyle: TextStyle(
                      color: dark ? Colors.white : Colors.black,
                      fontSize: 14,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 30),

              TCircularButton(
                text: 'Start Membership',
                textColor: TColors.white,
                backgroundColor: TColors.trainerPrimary,
                onTap: () {
                  try {
                    final Timestamp startDate =
                        Timestamp.fromDate(DateTime.now());
                    final String userId = UserController.instance.user.value.id;

                    // Debugging logs
                    print('User ID: $userId');
                    print('Membership ID: ${membership.id}');
                    print('Membership Duration: ${membership.duration}');

                    if (userId.isEmpty) {
                      print('Error: User ID is empty.');
                      return;
                    }
                    if (membership.duration is! int) {
                      print('Error: Membership duration is not an integer.');
                      return;
                    }

                    // Call the method to add membership
                    membershipController.addMembershipByUser(
                      userId: userId,
                      membershipId: membership.id,
                      startDate: startDate,
                      status: "active",
                      progress: 0,
                      duration: membership.duration,
                    );
                    membershipController.addMemberToTrainer(
                        trainerDetails.trainerId,
                        userId,
                        membership.id,
                        userController.user.value.profilePicture);
                  } catch (e) {
                    print('Error in Start Membership button: $e');
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build section titles
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: _buildTextStyle(),
    );
  }

  // Unified method to build row for detail info
  Widget _buildDetailRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$title: ',
          style: _buildTextStyle(),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  // Helper method to build list of certifications or languages
  Widget _buildListRow(String title, List<String> items) {
    return Row(
      children: [
        Icon(
          title == 'Certifications' ? Icons.verified : Icons.language,
          color: Colors.green,
        ),
        const SizedBox(width: 8),
        Text(
          '$title: ',
          style: _buildTextStyle(),
        ),
        Expanded(
          child: Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: items.map((item) {
              return Text(item);
            }).toList(),
          ),
        ),
      ],
    );
  }

  // Helper method to build the text style
  TextStyle _buildTextStyle() {
    return TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: TColors.primary,
    );
  }

  // Helper method to build detail columns for Price and Duration
  Widget _buildDetailColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: _buildTextStyle(),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
