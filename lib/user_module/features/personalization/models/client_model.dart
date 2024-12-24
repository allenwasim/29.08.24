import 'package:cloud_firestore/cloud_firestore.dart';

class ClientDetails {
  final List<Map<String, dynamic>> memberships;

  ClientDetails({required this.memberships});

  // Convert ClientDetails to JSON
  Map<String, dynamic> toJson() {
    return {
      'memberships': memberships,
    };
  }

  // Create ClientDetails from JSON
  factory ClientDetails.fromJson(Map<String, dynamic> json) {
    return ClientDetails(
      memberships: List<Map<String, dynamic>>.from(json['memberships'] ?? []),
    );
  }

  // Method to add a new membership
  void addMembership({
    required String membershipId,
    required Timestamp startDate,
    required Timestamp endDate,
    required String status,
    required int progress,
    required int workoutsCompleted,
    required int totalDays,
  }) {
    memberships.add({
      'membershipId': membershipId,
      'startDate': startDate,
      'endDate': endDate,
      'status': status,
      'progress': progress,
      'workoutsCompleted': workoutsCompleted,
      'totalDays': totalDays,
    });
  }

  // Method to update the progress of a membership
  void updateProgress(String membershipId, int progress) {
    final membership = memberships.firstWhere(
        (membership) => membership['membershipId'] == membershipId,
        orElse: () => {});
    if (membership.isNotEmpty) {
      membership['progress'] = progress;
    }
  }

  // Method to update the status of a membership
  void updateStatus(String membershipId, String status) {
    final membership = memberships.firstWhere(
        (membership) => membership['membershipId'] == membershipId,
        orElse: () => {});
    if (membership.isNotEmpty) {
      membership['status'] = status;
    }
  }

  // Method to calculate remaining workouts
  int remainingWorkouts(String membershipId) {
    final membership = memberships.firstWhere(
        (membership) => membership['membershipId'] == membershipId,
        orElse: () => {});
    if (membership.isNotEmpty) {
      return membership['totalDays'] - membership['workoutsCompleted'];
    }
    return 0;
  }

  // Method to fetch the membership by ID
  Map<String, dynamic> getMembershipById(String membershipId) {
    return memberships.firstWhere(
      (membership) => membership['membershipId'] == membershipId,
      orElse: () => {},
    );
  }
}
