import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/trainer_module/features/models/membership_model.dart';
import 'package:t_store/trainer_module/features/models/trainer_model.dart';
import 'package:t_store/user_module/features/personalization/screens/trainer_details_screen/trainer_details_screen.dart';
import 'package:t_store/user_module/data/repositories/client/live_session_repository.dart';
import 'package:t_store/user_module/features/authentication/controllers/client_details/client_details_controller.dart';
import 'package:t_store/utils/constants/image_strings.dart';

final LiveSessionRepository liveSessionRepository =
    Get.put(LiveSessionRepository());
final ClientDetailsController clientDetailsController =
    Get.put(ClientDetailsController());

class ActiveMembershipDetailScreen extends StatelessWidget {
  final MembershipModel membership;
  final TrainerDetails trainer;
  final dynamic clientMembership;

  const ActiveMembershipDetailScreen(
      {Key? key,
      required this.membership,
      required this.trainer,
      required this.clientMembership})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // Format dates using data from the ClientDetailsController
    final DateFormat dateFormat = DateFormat("MMM dd, yyyy");
    final startDate = clientMembership['startDate'] != null
        ? dateFormat.format(clientMembership['startDate'].toDate())
        : 'Unknown start date';
    final endDate = clientMembership['endDate'] != null
        ? dateFormat.format(clientMembership['endDate'].toDate())
        : 'No end date';

    // Calculate progress based on fetched data
    final int totalDays = membership.workouts.length;
    final int workoutsCompleted =
        membership.workouts.where((workout) => workout.isNotEmpty).length;
    final double progress = (workoutsCompleted / totalDays).clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Membership Privileges',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        backgroundColor: isDarkMode ? Colors.black : TColors.trainerPrimary,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Obx(() {
        if (clientDetailsController.detailsLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMembershipInfoCard(
                  context,
                  startDate,
                  endDate,
                ),
                const SizedBox(height: 16),
                _buildTrainerDetailsCard(context),
                const SizedBox(height: 16),
                _buildPrivilegesSection(context),
                const SizedBox(height: 16),
                _buildProgressSection(
                    context, progress, workoutsCompleted, totalDays),
                const SizedBox(height: 16),
                _buildActionButtons(context),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildMembershipInfoCard(BuildContext context,
      String startDateFormatted, String endDateFormatted) {
    final theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              membership.planName,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Status:", style: theme.textTheme.bodyMedium),
                Text(
                  membership.isAvailable ? "Active" : "Inactive",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: membership.isAvailable ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "Validity: $startDateFormatted - $endDateFormatted",
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrainerDetailsCard(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        // Navigate to a detailed trainer screen
        Get.to(() => TrainerDetailsScreen(trainer: trainer));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Profile Picture
              CircleAvatar(
                radius: 30,
                backgroundImage: trainer.profilePic.isNotEmpty
                    ? NetworkImage(trainer.profilePic)
                    : const AssetImage(TImages.user) as ImageProvider,
              ),
              const SizedBox(width: 16),

              // Preview Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trainer.name,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Specialization: ${trainer.expertise.isNotEmpty ? trainer.expertise.join(', ') : 'Not specified'}",
                      style: theme.textTheme.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          trainer.rating.toStringAsFixed(1),
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // View More Icon
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrivilegesSection(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Membership Privileges",
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            if (membership.workouts.isNotEmpty)
              Column(
                children: membership.workouts
                    .map((workout) => ListTile(
                          leading: Icon(Icons.check_circle,
                              color: theme.colorScheme.primary),
                          title:
                              Text(workout, style: theme.textTheme.bodyMedium),
                        ))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressSection(BuildContext context, double progress,
      int workoutsCompleted, int totalDays) {
    final theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Workout Progress",
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: theme.colorScheme.surfaceVariant,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 8),
            Text(
              "Completed: $workoutsCompleted/$totalDays Workouts",
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        _buildActionButton(
          context,
          'Join Live Session',
          Icons.video_call,
          theme.colorScheme.primary,
          () => liveSessionRepository.openMeetSession(
              context, membership.meetLink ?? "Not Available"),
        ),
        const SizedBox(height: 16),
        _buildActionButton(
          context,
          'Start Camera Workout',
          Icons.camera_alt,
          theme.colorScheme.secondary,
          () {
            // Handle camera workout logic
          },
        ),
        const SizedBox(height: 16),
        _buildActionButton(
          context,
          'Renew Membership',
          Icons.payment,
          Colors.orange,
          () {
            // Handle renewal logic
          },
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, String label, IconData icon,
      Color color, VoidCallback onPressed) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      icon: Icon(icon),
      label: Text(label),
      onPressed: onPressed,
    );
  }
}
