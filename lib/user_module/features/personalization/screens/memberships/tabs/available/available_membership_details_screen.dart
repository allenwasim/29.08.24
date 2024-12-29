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
                  // Fetch the client data from the clientDetails collection
                  final clientDoc = await FirebaseFirestore.instance
                      .collection('Profiles')
                      .doc(clientId)
                      .collection('clientDetails')
                      .doc('details')
                      .get();

                  if (clientDoc.exists) {
                    final clientData = clientDoc.data();
                    if (clientData != null) {
                      final client = ClientDetails.fromJson(clientData);

                      // Add the new membership
                      client.addMembership(
                        membershipId: membership.id,
                        startDate: Timestamp.now(),
                        duration: 1, // Actual duration calculation
                        status: 'Active',
                        progress: 0,
                        workoutsCompleted: 0,
                        totalDays: 30,
                      );

                      // Update the clientDetails document
                      await FirebaseFirestore.instance
                          .collection('Profiles')
                          .doc(clientId)
                          .collection('clientDetails')
                          .doc('details')
                          .update(client.toJson());

                      // Check if trainerDetails document exists
                      final trainerDoc = await FirebaseFirestore.instance
                          .collection('Profiles')
                          .doc(membership.trainerId)
                          .collection('trainerDetails')
                          .doc('details')
                          .get();

                      if (!trainerDoc.exists) {
                        // Create the trainerDetails document if it doesn't exist
                        await FirebaseFirestore.instance
                            .collection('Profiles')
                            .doc(membership.trainerId)
                            .collection('trainerDetails')
                            .doc('details')
                            .set({
                          'members': [],
                        });
                      }

                      // Add client membership to trainerDetails
                      await FirebaseFirestore.instance
                          .collection('Profiles')
                          .doc(membership.trainerId)
                          .collection('trainerDetails')
                          .doc('details')
                          .update({
                        'members': FieldValue.arrayUnion([
                          {
                            'clientId': clientId,
                            'membershipId': membership.id,
                            'startDate': Timestamp.now(),
                            'status': 'Active',
                          }
                        ])
                      });

                      // Navigate to the next screen
                      Get.off(
                          () => MembershipDetailScreen(membership: membership));
                    }
                  } else {
                    print("Client not found");
                  }
                } catch (e) {
                  print("Error adding membership: $e");
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
