class ActiveMembership {
  final String membershipName;
  final String trainerName;
  final String styleOfTraining;
  final String trainerImageUrl;
  final String backgroundImageUrl;
  final String? membershipDuration;
  final String? subscriptionRates;
  final DateTime startDate; // Required
  final DateTime endDate; // Required

  ActiveMembership({
    required this.membershipName,
    required this.trainerName,
    required this.styleOfTraining,
    required this.trainerImageUrl,
    required this.backgroundImageUrl,
    this.membershipDuration,
    this.subscriptionRates,
    required this.startDate, // Required
    required this.endDate, // Required
  });
}
