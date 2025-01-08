class ClientDetails {
  final String userId; // Unique identifier for the user
  final String name; // Name of the client
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
  final String profilePic; // New field for profile picture URL

  ClientDetails({
    required this.userId,
    required this.name,
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
    required this.profilePic,
  });

  // Convert ClientDetails to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
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
      'profilePic': profilePic, // Include profilePic in the JSON
    };
  }

  // Create ClientDetails from Firestore JSON (using fromJson)
  factory ClientDetails.fromJson(Map<String, dynamic> json) {
    return ClientDetails(
      userId: json['userId'] ?? '',
      name: json['name'] ?? '',
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
      profilePic: json['profilePic'] ?? '',
    );
  }

  // Add the fromMap method that works the same way as fromJson
  factory ClientDetails.fromMap(Map<String, dynamic> map) {
    return ClientDetails(
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      height: map['height'] ?? '',
      weight: map['weight'] ?? '',
      gender: map['gender'] ?? 'Not Specified',
      activityLevel: map['activityLevel'] ?? 'Sedentary',
      injuries: map['injuries'] ?? '',
      fitnessGoal: map['fitnessGoal'] ?? '',
      memberships: List<Map<String, dynamic>>.from(map['memberships'] ?? []),
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      profilePic: map['profilePic'] ?? '',
    );
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

  // Add membership with unique clientMembershipId
  void addMembership(Map<String, dynamic> newMembership) {
    String uniqueMembershipId =
        'client_${DateTime.now().millisecondsSinceEpoch}'; // Generate a unique ID using timestamp
    newMembership['clientMembershipId'] =
        uniqueMembershipId; // Add unique ID to membership
    memberships.add(newMembership); // Add to memberships list
  }

  // Update membership details by clientMembershipId
  void updateMembership(
      String clientMembershipId, Map<String, dynamic> updatedMembership) {
    final membershipIndex = memberships.indexWhere(
      (membership) => membership['clientMembershipId'] == clientMembershipId,
    );
    if (membershipIndex != -1) {
      memberships[membershipIndex] = updatedMembership;
    }
  }
}
