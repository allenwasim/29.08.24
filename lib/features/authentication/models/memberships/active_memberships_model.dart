class ActiveMembership {
  final String membershipName;
  final String trainerName;
  final String styleOfTraining;
  final String trainerImageUrl;
  final String backgroundImageUrl;
  final String? membershipDuration; // Optional field
  final String? subscriptionRates; // Optional field

  ActiveMembership({
    required this.membershipName,
    required this.trainerName,
    required this.styleOfTraining,
    required this.trainerImageUrl,
    required this.backgroundImageUrl,
    this.membershipDuration, // Optional parameter
    this.subscriptionRates, // Optional parameter
  });
}
