import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/utils/formatters/formatter.dart';

class MembershipModel {
  final String id;
  final String membershipId;
  final String trainerId;
  String planName;
  String description;
  double price;
  int duration;
  List<String> workouts;
  bool isAvailable;
  DateTime createdAt;

  // Nullable fields for Active Membership
  DateTime? startDate; // Nullable field for start date
  DateTime? endDate; // Nullable field for end date

  // Constructor with optional parameters
  MembershipModel({
    this.id = '',
    this.membershipId = '',
    this.trainerId = '',
    this.planName = '',
    this.description = '',
    this.price = 0.0,
    this.duration = 0,
    this.workouts = const [],
    this.isAvailable = true,
    DateTime? createdAt,
    this.startDate,
    this.endDate,
  }) : createdAt = createdAt ?? DateTime.now();

  // Named constructor for an empty membership model
  MembershipModel.empty()
      : id = '',
        membershipId = '',
        trainerId = '',
        planName = '',
        description = '',
        price = 0.0,
        duration = 0,
        workouts = [],
        isAvailable = true,
        createdAt = DateTime.now(),
        startDate = null,
        endDate = null;

  // Helper function to get formatted price
  String get formattedPrice => TFormatter.formatPrice(price);

  // Helper function to get formatted duration

  // Method to update plan name
  void updatePlanName(String newPlanName) {
    planName = newPlanName;
  }

  // Method to update description
  void updateDescription(String newDescription) {
    description = newDescription;
  }

  // Method to update price
  void updatePrice(double newPrice) {
    price = newPrice;
  }

  // Method to update workouts
  void updateWorkouts(List<String> newWorkouts) {
    workouts = newWorkouts;
  }

  // Method to update availability status
  void updateAvailability(bool newAvailability) {
    isAvailable = newAvailability;
  }

  // Method to convert MembershipModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'membershipId': membershipId,
      'trainerId': trainerId,
      'planName': planName,
      'description': description,
      'price': price,
      'duration': duration,
      'workouts': workouts,
      'isAvailable': isAvailable,
      'createdAt': createdAt,
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  // Method to create MembershipModel from Firestore document
  static Future<MembershipModel> fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) async {
    final data = document.data()!;

    // Ensure `duration` is parsed correctly, whether it's a String or int
    int parsedDuration = 0;
    if (data['duration'] is int) {
      parsedDuration = data['duration'];
    } else if (data['duration'] is String) {
      parsedDuration = int.tryParse(data['duration']) ?? 0;
    }

    return MembershipModel(
      id: document.id,
      membershipId: data['membershipId'] ?? '',
      trainerId: data['trainerId'] ?? '',
      planName: data['planName'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      duration: parsedDuration, // Use parsed duration
      workouts: List<String>.from(data['workouts'] ?? []),
      isAvailable: data['isAvailable'] ?? false,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      startDate: (data['startDate'] as Timestamp?)?.toDate(),
      endDate: (data['endDate'] as Timestamp?)?.toDate(),
    );
  }

  // Add this method to convert a Map<String, dynamic> into MembershipModel
  static MembershipModel fromMap(Map<String, dynamic> data) {
    // Ensure `duration` is parsed correctly, whether it's a String or int
    int parsedDuration = 0;
    if (data['duration'] is int) {
      parsedDuration = data['duration'];
    } else if (data['duration'] is String) {
      parsedDuration = int.tryParse(data['duration']) ?? 0;
    }

    return MembershipModel(
      id: data['id'] ?? '',
      membershipId: data['membershipId'] ?? '',
      trainerId: data['trainerId'] ?? '',
      planName: data['planName'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      duration: parsedDuration, // Use parsed duration
      workouts: List<String>.from(data['workouts'] ?? []),
      isAvailable: data['isAvailable'] ?? false,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      startDate: (data['startDate'] as Timestamp?)?.toDate(),
      endDate: (data['endDate'] as Timestamp?)?.toDate(),
    );
  }

  // Method to save MembershipModel to Firestore
  Future<void> save() async {
    final ref = FirebaseFirestore.instance.collection('memberships').doc(id);
    await ref.set(toJson());
  }

  // Method to update MembershipModel in Firestore
  Future<void> update() async {
    final ref = FirebaseFirestore.instance.collection('memberships').doc(id);
    await ref.update(toJson());
  }

  // Method to delete MembershipModel from Firestore
  Future<void> delete() async {
    final ref = FirebaseFirestore.instance.collection('memberships').doc(id);
    await ref.delete();
  }

  @override
  String toString() {
    return 'MembershipModel(id: $id, membershipId: $membershipId, trainerId: $trainerId, planName: $planName, description: $description, price: $price, duration: $duration, workouts: $workouts, isAvailable: $isAvailable, createdAt: $createdAt, startDate: $startDate, endDate: $endDate)';
  }
}
