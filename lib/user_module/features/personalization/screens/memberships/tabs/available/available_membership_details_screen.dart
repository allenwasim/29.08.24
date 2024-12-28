import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/buttons/circular_button.dart';
import 'package:t_store/user_module/data/repositories/user/user_repositries.dart';
import 'package:t_store/user_module/features/personalization/models/client_model.dart';
import 'package:t_store/user_module/features/personalization/screens/memberships/tabs/active/membership_training_screen.dart';
import 'package:t_store/user_module/features/personalization/screens/programmes/screens/level_deatails_screen.dart';
import 'package:t_store/utils/formatters/formatter.dart';
import 'package:t_store/trainer_module/features/models/membership_model.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';
import 'package:t_store/user_module/features/personalization/screens/training/training.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AvailableMembershipDetailsScreen extends StatelessWidget {
  final MembershipModel membership;
  final String clientId;

  const AvailableMembershipDetailsScreen({
    Key? key,
    required this.membership,
    required this.clientId,
  }) : super(key: key);

  // Fetch ClientDetails from Firestore
  Future<ClientDetails?> _getClientDetails() async {
    final clientDoc = await FirebaseFirestore.instance
        .collection('clients')
        .doc(clientId)
        .get();
    if (clientDoc.exists) {
      return ClientDetails.fromJson(clientDoc.data()!);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final dark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Membership Details'),
        backgroundColor: dark ? Colors.black : Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      membership.planName,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: dark ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      membership.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: dark ? Colors.white70 : Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Text(
                          'Price: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          membership.formattedPrice,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text(
                          'Duration: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          membership.duration,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Text(
                          'Available Workouts: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            membership.workouts.join(', '),
                            style: const TextStyle(fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            const Spacer(),
            // Start Membership Button
            TCircularButton(
              text: 'Start Membership',
              textColor: Colors.white,
              backgroundColor: Colors.green,
              onTap: () async {
                try {
                  // Fetch the client data from the new collection path
                  final clientDoc = await FirebaseFirestore.instance
                      .collection('Profiles') // Access the Profiles collection
                      .doc(clientId) // Get the document for the current user
                      .collection(
                          'clientDetails') // Access the clientDetails collection
                      .doc('details') // Access the details document
                      .get(); // Fetch the client document

                  if (clientDoc.exists) {
                    // Fetch the current client data
                    final clientData = clientDoc.data();

                    if (clientData != null) {
                      final client = ClientDetails.fromJson(clientData);

                      // Add the new membership
                      client.addMembership(
                        membershipId: membership.id,
                        startDate: Timestamp.now(),
                        endDate: Timestamp
                            .now(), // You'll probably need to calculate an actual end date
                        status:
                            'Active', // Or whatever the initial status should be
                        progress: 0,
                        workoutsCompleted: 0,
                        totalDays:
                            30, // Adjust the total days based on your logic
                      );

                      // Update Firestore with the new membership data
                      await FirebaseFirestore.instance
                          .collection(
                              'Profiles') // Access the Profiles collection
                          .doc(
                              clientId) // Get the document for the current user
                          .collection(
                              'clientDetails') // Access the clientDetails collection
                          .doc('details') // Access the details document
                          .update(client
                              .toJson()); // Update the client document with new data

                      // Navigate to the next screen
                      Get.offAll(() => MembershipDetailScreen(
                            membership: membership,
                          ));
                    }
                  } else {
                    // Handle case where client does not exist
                    print("Client not found");
                  }
                } catch (e) {
                  // Handle any errors
                  print("Error adding membership: $e");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
