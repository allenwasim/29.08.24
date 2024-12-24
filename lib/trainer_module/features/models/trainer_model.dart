class TrainerDetails {
  // Fields specific to the trainer (no longer final)
  String trainerId; // Unique identifier for the trainer
  String bio; // A short bio about the trainer
  String expertise; // The areas of expertise, e.g., Yoga, Weight Training
  int yearsOfExperience; // Number of years of experience
  double rating; // Average rating from clients
  List<String> certifications; // List of certifications
  List<String> languages; // Languages spoken by the trainer
  String
      availability; // Availability status, e.g., "Available", "Busy", "Offline"

  // Constructor for TrainerDetails
  TrainerDetails({
    required this.trainerId,
    required this.bio,
    required this.expertise,
    required this.yearsOfExperience,
    required this.rating,
    required this.certifications,
    required this.languages,
    required this.availability,
  });

  // Named constructor for an empty trainer model
  TrainerDetails.empty()
      : trainerId = '',
        bio = '',
        expertise = '',
        yearsOfExperience = 0,
        rating = 0.0,
        certifications = [],
        languages = [],
        availability = '';

  // Method to update trainer details
  void updateTrainerDetails({
    String? bio,
    String? expertise,
    int? yearsOfExperience,
    double? rating,
    List<String>? certifications,
    List<String>? languages,
    String? availability,
  }) {
    if (bio != null) this.bio = bio;
    if (expertise != null) this.expertise = expertise;
    if (yearsOfExperience != null) this.yearsOfExperience = yearsOfExperience;
    if (rating != null) this.rating = rating;
    if (certifications != null) this.certifications = certifications;
    if (languages != null) this.languages = languages;
    if (availability != null) this.availability = availability;
  }

  // Method to convert TrainerDetails to JSON
  Map<String, dynamic> toJson() {
    return {
      'trainerId': trainerId,
      'bio': bio,
      'expertise': expertise,
      'yearsOfExperience': yearsOfExperience,
      'rating': rating,
      'certifications': certifications,
      'languages': languages,
      'availability': availability,
    };
  }

  // Method to create TrainerDetails from JSON
  factory TrainerDetails.fromJson(Map<String, dynamic> json) {
    return TrainerDetails(
      trainerId: json['trainerId'] ?? '',
      bio: json['bio'] ?? '',
      expertise: json['expertise'] ?? '',
      yearsOfExperience: json['yearsOfExperience'] ?? 0,
      rating: json['rating'] ?? 0.0,
      certifications: List<String>.from(json['certifications'] ?? []),
      languages: List<String>.from(json['languages'] ?? []),
      availability: json['availability'] ?? '',
    );
  }

  // Method to display trainer information
  @override
  String toString() {
    return 'TrainerDetails(trainerId: $trainerId, bio: $bio, expertise: $expertise, yearsOfExperience: $yearsOfExperience, rating: $rating, certifications: $certifications, languages: $languages, availability: $availability)';
  }
}
