import 'package:cloud_firestore/cloud_firestore.dart';

class ClientDetails {
  final String userId; // Unique identifier for the user
  final String height; // Height in cm
  final String weight; // Weight in kg
  final String gender; // Male, Female, or Not Specified
  final String activityLevel; // Sedentary, Lightly Active, etc.
  final String injuries; // Description of injuries, if any
  final String fitnessGoal; // User's fitness goal
  final List<Map<String, dynamic>> memberships; // List of memberships
  final String email; // User's email
  final String address; // User's address
  final String phoneNumber; // User's phone number

  ClientDetails({
    required this.userId,
    required this.height,
    required this.weight,
    required this.gender,
    required this.activityLevel,
    required this.injuries,
    required this.fitnessGoal,
    required this.memberships,
    required this.email,
    required this.address,
    required this.phoneNumber,
  });

  // Convert ClientDetails to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'height': height,
      'weight': weight,
      'gender': gender,
      'activityLevel': activityLevel,
      'injuries': injuries,
      'fitnessGoal': fitnessGoal,
      'memberships': memberships,
      'email': email,
      'address': address,
      'phoneNumber': phoneNumber,
    };
  }

  // Create ClientDetails from Firestore JSON
  factory ClientDetails.fromJson(Map<String, dynamic> json) {
    return ClientDetails(
      userId: json['userId'] ?? '',
      height: json['height'] ?? '',
      weight: json['weight'] ?? '',
      gender: json['gender'] ?? 'Not Specified',
      activityLevel: json['activityLevel'] ?? 'Sedentary',
      injuries: json['injuries'] ?? '',
      fitnessGoal: json['fitnessGoal'] ?? '',
      memberships: List<Map<String, dynamic>>.from(json['memberships'] ?? []),
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
    );
  }

  // Add a new membership with duration instead of endDate
  void addMembership({
    required String membershipId,
    required Timestamp startDate,
    required String status,
    required int progress,
    required int workoutsCompleted,
    required int totalDays,
    required int duration, // duration in months
  }) {
    // Calculate the end date by adding 'duration' months to the start date
    DateTime start = startDate.toDate();
    DateTime end = start
        .add(Duration(days: 30 * duration)); // Add 'duration' months (roughly)

    memberships.add({
      'membershipId': membershipId,
      'startDate': startDate,
      'endDate': Timestamp.fromDate(end), // Set the calculated end date
      'status': status,
      'progress': progress,
      'workoutsCompleted': workoutsCompleted,
      'totalDays': totalDays,
    });
  }

  // Update progress for a specific membership
  void updateProgress(String membershipId, int progress) {
    final membership = memberships.firstWhere(
        (membership) => membership['membershipId'] == membershipId,
        orElse: () => {});
    if (membership.isNotEmpty) {
      membership['progress'] = progress;
    }
  }

  // Update status for a specific membership
  void updateStatus(String membershipId, String status) {
    final membership = memberships.firstWhere(
        (membership) => membership['membershipId'] == membershipId,
        orElse: () => {});
    if (membership.isNotEmpty) {
      membership['status'] = status;
    }
  }

  // Calculate remaining workouts
  int remainingWorkouts(String membershipId) {
    final membership = memberships.firstWhere(
        (membership) => membership['membershipId'] == membershipId,
        orElse: () => {});
    if (membership.isNotEmpty) {
      return membership['totalDays'] - membership['workoutsCompleted'];
    }
    return 0;
  }

  // Fetch membership details by ID
  Map<String, dynamic> getMembershipById(String membershipId) {
    return memberships.firstWhere(
      (membership) => membership['membershipId'] == membershipId,
      orElse: () => {},
    );
  }

  // Function to get userId
  String getUserId() {
    return userId;
  }
}
