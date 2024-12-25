class ActiveMembership {
  final String membershipName; // e.g., "Gold Membership"
  final String trainerName;
  final String styleOfTraining;
  final String trainerImageUrl;
  final String backgroundImageUrl;
  final String? membershipDuration; // e.g., "Monthly" or "Annual"
  final String? subscriptionRates; // e.g., "₹999/month"
  final DateTime? startDate; // Required
  final DateTime? endDate; // Required
  final List<String>? keyBenefits; // e.g., ["Yoga Classes", "1-on-1 Sessions"]
  final int? workoutsCompleted; // Optional usage stat
  final int? totalDays; // Total days in the membership period
  final String trainerId; // New field for trainerId

  ActiveMembership({
    required this.membershipName,
    required this.trainerName,
    required this.styleOfTraining,
    required this.trainerImageUrl,
    required this.backgroundImageUrl,
    this.membershipDuration,
    this.subscriptionRates,
    this.startDate,
    this.endDate,
    this.keyBenefits,
    this.workoutsCompleted,
    this.totalDays,
    required this.trainerId, // Initialize trainerId in the constructor
  });

  // Calculate remaining days
  int get remainingDays {
    return endDate!.difference(DateTime.now()).inDays.clamp(0, totalDays ?? 0);
  }

  // Determine membership status
  String get membershipStatus {
    if (DateTime.now().isBefore(startDate!)) {
      return "Not Yet Active";
    } else if (DateTime.now().isAfter(endDate!)) {
      return "Expired";
    } else if (remainingDays <= 7) {
      return "About to Expire";
    }
    return "Active";
  }
}
