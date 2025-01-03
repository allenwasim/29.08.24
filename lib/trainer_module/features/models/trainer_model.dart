class Member {
  final String clientId; // Unique identifier for the client
  final String membershipId; // Unique identifier for the membership
  final String profilePic; // Profile picture URL for the member

  // Constructor
  Member({
    required this.clientId,
    required this.membershipId,
    required this.profilePic,
  });

  // Method to convert Member to JSON
  Map<String, dynamic> toJson() {
    return {
      'clientId': clientId,
      'membershipId': membershipId,
      'profilePic': profilePic,
    };
  }

  // Factory to create Member from JSON
  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      clientId: json['clientId'] ?? '',
      membershipId: json['membershipId'] ?? '',
      profilePic: json['profilePic'] ?? '', // Handle profilePic
    );
  }

  @override
  String toString() {
    return 'Member(clientId: $clientId, membershipId: $membershipId, profilePic: $profilePic)';
  }
}

class TrainerDetails {
  String trainerId;
  String name;
  String bio;
  String expertise;
  int yearsOfExperience;
  double rating;
  List<String> certifications;
  List<String> languages;
  String availability;
  List<Member> members;
  String profilePic;

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
    required this.members,
    required this.profilePic,
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
        members = [],
        profilePic = '';

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
    String? profilePic,
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
    if (profilePic != null) this.profilePic = profilePic;
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
      'profilePic': profilePic,
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
      members: (json['members'] as List<dynamic>? ?? [])
          .map((memberJson) => Member.fromJson(memberJson))
          .toList(),
      profilePic: json['profilePic'] ?? '',
    );
  }

  @override
  String toString() {
    return 'TrainerDetails(trainerId: $trainerId, name: $name, bio: $bio, expertise: $expertise, yearsOfExperience: $yearsOfExperience, rating: $rating, certifications: $certifications, languages: $languages, availability: $availability, profilePic: $profilePic, members: $members)';
  }
}
