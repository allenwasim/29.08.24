import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/trainer_module/features/controllers/membership_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:t_store/user_module/features/authentication/controllers/client_details/client_details_controller.dart';

class ClientMembershipDetails extends StatelessWidget {
  final String trainerId;
  final dynamic client;
  final Timestamp startDate;
  final Timestamp endDate;
  final String membershipId;
  final dynamic membership;

  final MembershipController membershipController =
      Get.put(MembershipController());

  ClientMembershipDetails({
    super.key,
    required this.trainerId,
    required this.client,
    required this.startDate,
    required this.endDate,
    required this.membershipId,
    this.membership,
  });

  @override
  Widget build(BuildContext context) {
    // Fetch membership details only when necessary
    membershipController.fetchMembershipDetails(trainerId);

    // Fetch client details

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
        // Check if membership details are still loading

        // Accessing membership details
        final memberships = membershipController.membershipDetails;
        if (memberships.isEmpty) {
          return const Center(child: Text("No membership details available."));
        }
        final membership = memberships[0];

        // Access client details
        if (client == null) {
          return const Center(child: Text("Client details unavailable."));
        }

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
              // Client's profile image
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image.network(
                    client.profilePic ??
                        'https://via.placeholder.com/100', // Placeholder for missing image
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
                  client.name ?? "N/A",
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
                  membership.planName ?? "N/A",
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
                        client.height?.toString() ?? "N/A",
                      ),
                      _buildDetailRow(
                        Icons.fitness_center,
                        'Weight',
                        client.weight?.toString() ?? "N/A",
                      ),
                      _buildDetailRow(
                        Icons.person,
                        'Gender',
                        client.gender ?? "N/A",
                      ),
                      _buildDetailRow(
                        Icons.accessibility,
                        'Activity Level',
                        client.activityLevel ?? "N/A",
                      ),
                      _buildDetailRow(
                        Icons.medical_services,
                        'Injuries',
                        client.injuries ?? "None",
                      ),
                      _buildDetailRow(
                        Icons.flag,
                        'Fitness Goal',
                        client.fitnessGoal ?? "N/A",
                      ),
                      _buildDetailRow(
                        Icons.email,
                        'Email',
                        client.email ?? "N/A",
                      ),
                      _buildDetailRow(
                        Icons.home,
                        'Address',
                        client.address ?? "N/A",
                      ),
                      _buildDetailRow(
                        Icons.phone,
                        'Phone Number',
                        client.phoneNumber ?? "N/A",
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
          const Expanded(child: Text(":")),
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
