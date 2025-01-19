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

class Earning {
  final double amount; // Earnings amount
  final DateTime date; // Date of the earning

  // Constructor
  Earning({
    required this.amount,
    required this.date,
  });

  // Method to convert Earning to JSON
  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'date': date.toIso8601String(),
    };
  }

  // Factory to create Earning from JSON
  factory Earning.fromJson(Map<String, dynamic> json) {
    return Earning(
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date']),
    );
  }

  @override
  String toString() {
    return 'Earning(amount: $amount, date: $date)';
  }
}

class TrainerDetails {
  String trainerId;
  String name;
  String bio;
  List<String> expertise;
  int yearsOfExperience;
  double rating;
  List<String> certifications;
  List<String> languages;
  String availability;
  List<Member> members;
  String profilePic;
  List<Earning> earnings; // Changed earnings to a list of Earning

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
    required this.earnings, // Updated field
  });

  // Named constructor for an empty trainer model
  TrainerDetails.empty()
      : trainerId = '',
        name = '',
        bio = '',
        expertise = [],
        yearsOfExperience = 0,
        rating = 0.0,
        certifications = [],
        languages = [],
        availability = '',
        members = [],
        profilePic = '',
        earnings = []; // Default value for earnings

  // Method to add a new earning entry
  void addEarning(Earning earning) {
    earnings.add(earning);
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
      'earnings': earnings
          .map((earning) => earning.toJson())
          .toList(), // Serialize earnings
    };
  }

  // Factory to create TrainerDetails from JSON
  factory TrainerDetails.fromJson(Map<String, dynamic> json) {
    return TrainerDetails(
      trainerId: json['trainerId'] ?? '',
      name: json['name'] ?? '',
      bio: json['bio'] ?? '',
      expertise: List<String>.from(json['expertise'] ?? []),
      yearsOfExperience: json['yearsOfExperience'] ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      certifications: List<String>.from(json['certifications'] ?? []),
      languages: List<String>.from(json['languages'] ?? []),
      availability: json['availability'] ?? '',
      members: (json['members'] as List<dynamic>? ?? [])
          .map((memberJson) => Member.fromJson(memberJson))
          .toList(),
      profilePic: json['profilePic'] ?? '',
      earnings: (json['earnings'] as List<dynamic>? ?? [])
          .map((earningJson) => Earning.fromJson(earningJson))
          .toList(), // Deserialize earnings
    );
  }

  @override
  String toString() {
    return 'TrainerDetails(trainerId: $trainerId, name: $name, bio: $bio, expertise: $expertise, yearsOfExperience: $yearsOfExperience, rating: $rating, certifications: $certifications, languages: $languages, availability: $availability, profilePic: $profilePic, earnings: $earnings, members: $members)';
  }
}
