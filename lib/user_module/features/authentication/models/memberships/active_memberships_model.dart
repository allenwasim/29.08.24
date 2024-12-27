// class ActiveMembership {
//   final String membershipName;
//   final String trainerName;
//   final String styleOfTraining;
//   final String trainerImageUrl;
//   final String backgroundImageUrl;
//   final String? membershipDuration;
//   final String? subscriptionRates;
//   final DateTime? startDate;
//   final DateTime? endDate;
//   final List<String>? keyBenefits;
//   final int? workoutsCompleted;
//   final int? totalDays;
//   final String trainerId;

//   // Add workouts field to track a list of workout names
//   final List<String>? workouts; // e.g., ["Yoga", "Pilates", "Cardio"]

//   ActiveMembership.Membership({
//     required this.membershipName,
//     required this.trainerName,
//     required this.styleOfTraining,
//     required this.trainerImageUrl,
//     required this.backgroundImageUrl,
//     this.membershipDuration,
//     this.subscriptionRates,
//     this.startDate,
//     this.endDate,
//     this.keyBenefits,
//     this.workoutsCompleted,
//     this.totalDays,
//     required this.trainerId,
//     this.workouts, // Initialize workouts in the constructor
//   });

//   int get remainingDays {
//     return endDate!.difference(DateTime.now()).inDays.clamp(0, totalDays ?? 0);
//   }

//   String get membershipStatus {
//     if (DateTime.now().isBefore(startDate!)) {
//       return "Not Yet Active";
//     } else if (DateTime.now().isAfter(endDate!)) {
//       return "Expired";
//     } else if (remainingDays <= 7) {
//       return "About to Expire";
//     }
//     return "Active";
//   }
// }
