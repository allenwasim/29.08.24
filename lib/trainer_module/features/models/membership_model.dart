import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/utils/formatters/formatter.dart';

class MembershipModel {
  final String id;
  final String membershipId;
  final String trainerId;
  String planName;
  String description;
  double price;
  String duration;
  List<String> workouts;
  bool isAvailable;
  DateTime createdAt;

  // Nullable fields for Active Membership
  DateTime? startDate; // Nullable field for start date
  DateTime? endDate; // Nullable field for end date

  // Constructor
  MembershipModel({
    required this.id,
    required this.membershipId,
    required this.trainerId,
    required this.planName,
    required this.description,
    required this.price,
    required this.duration,
    required this.workouts,
    required this.isAvailable,
    required this.createdAt,
    this.startDate, // Nullable start date
    this.endDate, // Nullable end date
  });

  // Named constructor for an empty membership model
  MembershipModel.empty()
      : id = '',
        membershipId = '',
        trainerId = '',
        planName = '',
        description = '',
        price = 0,
        duration = '',
        workouts = [],
        isAvailable = true,
        createdAt = DateTime.now(),
        startDate = null,
        endDate = null;

  // Other methods...

  // Helper function to get formatted price
  String get formattedPrice => TFormatter.formatPrice(price);

  // Method to convert MembershipModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'membershipId': membershipId, // Include membershipId in Firestore data
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
    return MembershipModel(
      id: document.id,
      membershipId: data['membershipId'] ?? '', // Read membershipId
      trainerId: data['trainerId'] ?? '',
      planName: data['planName'] ?? '',
      description: data['description'] ?? '',
      price: data['price'] ?? 0.0,
      duration: data['duration'] ?? '',
      workouts: List<String>.from(data['workouts'] ?? []),
      isAvailable: data['isAvailable'] ?? true,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      startDate: (data['startDate'] as Timestamp).toDate(),
      endDate: (data['endDate'] as Timestamp).toDate(),
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
