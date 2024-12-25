import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:t_store/user_module/features/authentication/models/memberships/active_memberships_model.dart';

class MembershipDetailScreen extends StatelessWidget {
  final ActiveMembership membership;

  const MembershipDetailScreen({Key? key, required this.membership})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Format the dates using DateFormat
    final DateFormat dateFormat = DateFormat("MMM dd, yyyy");
    final String startDateFormatted = dateFormat.format(membership.startDate!);
    final String endDateFormatted = dateFormat.format(membership.endDate!);

    // Calculate progress and usage stats
    final int? totalDays = membership.totalDays;
    final int? workoutsCompleted = membership.workoutsCompleted;
    final double progress = (workoutsCompleted ?? 0) / (totalDays ?? 1);

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              membership.backgroundImageUrl,
              fit: BoxFit.cover,
            ),
          ),
          // Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.6),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // Back Button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.5),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
          ),
          // Main Content
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 80), // Spacing below the back button
                    // Membership Plan Header
                    buildMembershipHeader(context, isDarkMode,
                        startDateFormatted, endDateFormatted),

                    const SizedBox(height: 24),
                    // Key Benefits Section
                    buildKeyBenefitsSection(context, isDarkMode),

                    const SizedBox(height: 24),
                    // Progress Section
                    buildProgressSection(context, isDarkMode, progress,
                        workoutsCompleted, totalDays),

                    const SizedBox(height: 24),
                    // Live Sessions Button
                    ElevatedButton.icon(
                      onPressed: () {
                        // Handle live session logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200], // Subtle gray button
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      icon: const Icon(Icons.video_call, color: Colors.black),
                      label: const Text("Join Live Session",
                          style: TextStyle(color: Colors.black)),
                    ),

                    const SizedBox(height: 16),
                    // Camera Workout Feature
                    ElevatedButton.icon(
                      onPressed: () {
                        // Handle camera workout logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200], // Subtle gray button
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      icon: const Icon(Icons.camera_alt, color: Colors.black),
                      label: const Text("Start Camera Workout",
                          style: TextStyle(color: Colors.black)),
                    ),

                    const SizedBox(height: 16),
                    // Payment Button
                    ElevatedButton.icon(
                      onPressed: () {
                        // Handle payment logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200], // Subtle gray button
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      icon: const Icon(Icons.payment, color: Colors.black),
                      label: const Text("Renew Membership",
                          style: TextStyle(color: Colors.black)),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMembershipHeader(BuildContext context, bool isDarkMode,
      String startDateFormatted, String endDateFormatted) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 2,
      color: isDarkMode ? Colors.grey[850] : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              membership.membershipName,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text("Status: ", style: Theme.of(context).textTheme.bodyMedium),
                Text(
                  membership.membershipStatus,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: membership.membershipStatus == "Active"
                            ? Colors.green
                            : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text("Validity: $startDateFormatted - $endDateFormatted",
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  Widget buildKeyBenefitsSection(BuildContext context, bool isDarkMode) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 2,
      color: isDarkMode ? Colors.grey[850] : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Key Benefits",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
            ),
            const SizedBox(height: 8),
            if (membership.keyBenefits != null)
              Column(
                children: membership.keyBenefits!
                    .map((benefit) => ListTile(
                          leading: const Icon(Icons.check_circle,
                              color: Colors.green),
                          title: Text(benefit),
                        ))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildProgressSection(BuildContext context, bool isDarkMode,
      double progress, int? workoutsCompleted, int? totalDays) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 2,
      color: isDarkMode ? Colors.grey[850] : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Usage Stats",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: isDarkMode ? Colors.grey : Colors.grey[300],
              color: Colors.green,
            ),
            const SizedBox(height: 8),
            Text(
              "Workouts completed: $workoutsCompleted/$totalDays days",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
