class Member {
  final String clientId; // Unique identifier for the client
  final String membershipId; // Unique identifier for the membership

  // Constructor
  Member({
    required this.clientId,
    required this.membershipId,
  });

  // Method to convert Member to JSON
  Map<String, dynamic> toJson() {
    return {
      'clientId': clientId,
      'membershipId': membershipId,
    };
  }

  // Factory to create Member from JSON
  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      clientId: json['clientId'] ?? '',
      membershipId: json['membershipId'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Member(clientId: $clientId, membershipId: $membershipId)';
  }
}

class TrainerDetails {
  // Fields specific to the trainer (no longer final)
  String trainerId; // Unique identifier for the trainer
  String name; // Trainer's name
  String bio; // A short bio about the trainer
  String expertise; // The areas of expertise, e.g., Yoga, Weight Training
  int yearsOfExperience; // Number of years of experience
  double rating; // Average rating from clients
  List<String> certifications; // List of certifications
  List<String> languages; // Languages spoken by the trainer
  String
      availability; // Availability status, e.g., "Available", "Busy", "Offline"
  List<Member> members; // List of members associated with the trainer

  // Constructor for TrainerDetails
  TrainerDetails({
    required this.trainerId,
    required this.name,
    required this.bio,
    required this.expertise,
    required this.yearsOfExperience,
    required this.rating,
    required this.certifications,
    required this.languages,
    required this.availability,
    required this.members, // Pass list of members
  });

  // Named constructor for an empty trainer model
  TrainerDetails.empty()
      : trainerId = '',
        name = '',
        bio = '',
        expertise = '',
        yearsOfExperience = 0,
        rating = 0.0,
        certifications = [],
        languages = [],
        availability = '',
        members = [];

  // Method to add a new member to the trainer's member list
  void addMemberToTrainerDetails(Member member) {
    members.add(member);
  }

  // Method to update trainer details
  void updateTrainerDetails({
    String? name,
    String? bio,
    String? expertise,
    int? yearsOfExperience,
    double? rating,
    List<String>? certifications,
    List<String>? languages,
    String? availability,
    List<Member>? members,
  }) {
    if (name != null) this.name = name;
    if (bio != null) this.bio = bio;
    if (expertise != null) this.expertise = expertise;
    if (yearsOfExperience != null) this.yearsOfExperience = yearsOfExperience;
    if (rating != null) this.rating = rating;
    if (certifications != null) this.certifications = certifications;
    if (languages != null) this.languages = languages;
    if (availability != null) this.availability = availability;
    if (members != null) this.members = members;
  }

  // Method to convert TrainerDetails to JSON
  Map<String, dynamic> toJson() {
    return {
      'trainerId': trainerId,
      'name': name,
      'bio': bio,
      'expertise': expertise,
      'yearsOfExperience': yearsOfExperience,
      'rating': rating,
      'certifications': certifications,
      'languages': languages,
      'availability': availability,
      'members': members.map((member) => member.toJson()).toList(),
    };
  }

  // Method to create TrainerDetails from JSON
  factory TrainerDetails.fromJson(Map<String, dynamic> json) {
    return TrainerDetails(
      trainerId: json['trainerId'] ?? '',
      name: json['name'] ?? '',
      bio: json['bio'] ?? '',
      expertise: json['expertise'] ?? '',
      yearsOfExperience: json['yearsOfExperience'] ?? 0,
      rating: json['rating'] ?? 0.0,
      certifications: List<String>.from(json['certifications'] ?? []),
      languages: List<String>.from(json['languages'] ?? []),
      availability: json['availability'] ?? '',
      members: (json['members'] as List<dynamic>?)
              ?.map((memberJson) => Member.fromJson(memberJson))
              .toList() ??
          [],
    );
  }

  @override
  String toString() {
    return 'TrainerDetails(trainerId: $trainerId, name: $name, bio: $bio, expertise: $expertise, yearsOfExperience: $yearsOfExperience, rating: $rating, certifications: $certifications, languages: $languages, availability: $availability, members: $members)';
  }
}
