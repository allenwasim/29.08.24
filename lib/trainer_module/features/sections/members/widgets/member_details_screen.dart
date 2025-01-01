import 'package:flutter/material.dart';
import 'package:t_store/constants/colors.dart';

class MemberDetails extends StatelessWidget {
  const MemberDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy data
    final String profilePic = '';
    final String name = 'John Doe';
    final String email = 'john.doe@example.com';
    final String gender = 'Male';
    final String height = '180 cm';
    final String weight = '75 kg';
    final String activityLevel = 'Active';
    final String fitnessGoal = 'Weight Loss';
    final String phoneNumber = '+1234567890';
    final String address = '123 Fitness Lane, Fit City';
    final List<Map<String, dynamic>> memberships = [
      {
        'membershipId': '001',
        'startDate': '2024-01-01',
        'endDate': '2024-12-31',
        'status': 'Active',
        'progress': 75,
      },
      {
        'membershipId': '002',
        'startDate': '2023-01-01',
        'endDate': '2023-12-31',
        'status': 'Expired',
        'progress': 100,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColors.trainerPrimary,
        title: const Text('Member Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture and Name
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage:
                      profilePic.isNotEmpty ? NetworkImage(profilePic) : null,
                  child: profilePic.isEmpty
                      ? const Icon(Icons.person, size: 40)
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(email),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // General Information
            _buildInfoRow('Gender', gender),
            _buildInfoRow('Height', height),
            _buildInfoRow('Weight', weight),
            _buildInfoRow('Activity Level', activityLevel),
            _buildInfoRow('Fitness Goal', fitnessGoal),
            _buildInfoRow('Phone Number', phoneNumber),
            _buildInfoRow('Address', address),
            const SizedBox(height: 24),

            // Memberships Section
            Text(
              'Memberships',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            ...memberships.map((membership) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Text('Membership ID: ${membership['membershipId']}'),
                  subtitle: Text(
                      'Status: ${membership['status']}\nStart: ${membership['startDate']}\nEnd: ${membership['endDate']}'),
                  trailing: Text(
                    '${membership['progress']}%',
                    style: TextStyle(
                      color: TColors.trainerPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }).toList(),
            const SizedBox(height: 16),

            // Add Membership Button
            ElevatedButton.icon(
              onPressed: () {
                // Dummy button action
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Membership'),
              style: ElevatedButton.styleFrom(
                backgroundColor: TColors.trainerPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value, overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}
