import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/trainer_module/features/controllers/membership_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ClientMembershipDetails extends StatelessWidget {
  final String trainerId;
  final int index;
  final Timestamp startDate;
  final Timestamp endDate;
  final String membershipId;

  final MembershipController membershipController =
      Get.put(MembershipController());

  ClientMembershipDetails({
    required this.trainerId,
    required this.index,
    required this.startDate,
    required this.endDate,
    required this.membershipId,
  });

  @override
  Widget build(BuildContext context) {
    // Fetch membership details only when necessary
    membershipController.fetchMembershipDetails(trainerId);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColors.trainerPrimary,
        title: Text(
          'Membership Details',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Obx(() {
        // Checking if the membership details are still loading
        if (membershipController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        // Accessing membership details
        final memberships = membershipController.membershipDetails;
        final clients = membershipController.clientDetails;

        if (memberships.isEmpty || index >= memberships.length) {
          return Center(child: Text("No membership details found"));
        }

        // Proceed with displaying membership details if available
        final membership = memberships[index];
        final client = clients[0]; // Assuming only one client exists

        // Convert Firebase Timestamps to DateTime
        final startDateTime = startDate.toDate();
        final endDateTime = endDate.toDate();

        // Calculate remaining days from the passed end date
        int remainingDays = calculateRemainingDays(endDateTime);

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Client's profile image (just for demo, adjust to match your actual model)
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image.network(
                    client
                        .profilePic, // Assuming the profile picture URL is part of the MembershipModel
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Client's name
              Center(
                child: Text(
                  client.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Membership plan name
              Center(
                child: Text(
                  membership.planName,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? TColors.primary
                        : TColors.trainerPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Membership details card
              Card(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[850]
                    : Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildDetailRow(
                        Icons.confirmation_number,
                        'Membership ID',
                        membershipId,
                      ),
                      _buildDetailRow(
                        Icons.date_range,
                        'Start Date',
                        DateFormat('yyyy-MM-dd').format(startDateTime),
                      ),
                      _buildDetailRow(
                        Icons.event,
                        'End Date',
                        DateFormat('yyyy-MM-dd').format(endDateTime),
                      ),
                      _buildDetailRow(
                        Icons.timer,
                        'Duration',
                        membership.duration.toString(),
                      ),
                      _buildDetailRow(
                        Icons.access_time,
                        'Remaining Days',
                        '$remainingDays days',
                      ),
                      // Additional client details
                      _buildDetailRow(
                        Icons.height,
                        'Height',
                        client.height ??
                            "N/A", // Handle null values if height is missing
                      ),
                      _buildDetailRow(
                        Icons.fitness_center,
                        'Weight',
                        client.weight ??
                            "N/A", // Handle null values if weight is missing
                      ),
                      _buildDetailRow(
                        Icons.person,
                        'Gender',
                        client.gender ??
                            "N/A", // Handle null values if gender is missing
                      ),
                      _buildDetailRow(
                        Icons.accessibility,
                        'Activity Level',
                        client.activityLevel ??
                            "N/A", // Handle null values if activity level is missing
                      ),
                      _buildDetailRow(
                        Icons.medical_services,
                        'Injuries',
                        client.injuries ??
                            "None", // Handle null values if injuries are missing
                      ),
                      _buildDetailRow(
                        Icons.flag,
                        'Fitness Goal',
                        client.fitnessGoal ??
                            "N/A", // Handle null values if fitness goal is missing
                      ),
                      _buildDetailRow(
                        Icons.email,
                        'Email',
                        client.email ??
                            "N/A", // Handle null values if email is missing
                      ),
                      _buildDetailRow(
                        Icons.home,
                        'Address',
                        client.address ??
                            "N/A", // Handle null values if address is missing
                      ),
                      _buildDetailRow(
                        Icons.phone,
                        'Phone Number',
                        client.phoneNumber ??
                            "N/A", // Handle null values if phone number is missing
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  // Function to calculate the remaining days based on the end date
  int calculateRemainingDays(DateTime endDateTime) {
    final currentDate = DateTime.now();
    final difference = endDateTime.difference(currentDate);
    return difference.inDays;
  }

  Widget _buildDetailRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: TColors.trainerPrimary,
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 4,
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: TColors.primary,
              ),
            ),
          ),
          Expanded(child: Text(":")),
          Expanded(
            flex: 5,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
