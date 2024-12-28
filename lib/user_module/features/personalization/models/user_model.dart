import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/trainer_module/features/models/trainer_model.dart';
import 'package:t_store/user_module/features/personalization/models/client_model.dart';
import 'package:t_store/utils/formatters/formatter.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String email;
  final String username;
  String phoneNumber;
  String profilePicture;
  String role;

  // Updated to handle subcollection fetching
  TrainerDetails? trainerDetails;
  ClientDetails? clientDetails;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    this.phoneNumber = '',
    this.profilePicture = '',
    this.role = 'client',
  });

  // Named constructor for an empty user model
  UserModel.empty()
      : id = '',
        firstName = '',
        lastName = '',
        email = '',
        username = '',
        phoneNumber = '',
        profilePicture = '',
        role = '',
        trainerDetails = null,
        clientDetails = null;

  // Helper function to get the full name.
  String get fullName => '$firstName $lastName';

  // Helper function to get formatted phone number.
  String get formattedPhoneNumber => TFormatter.formatPhoneNumber(phoneNumber);

  // Static function to split full name into first and last name.
  static List<String> splitFullName(String fullName) {
    return fullName.split(' ');
  }

  // Method to update profile picture
  void updateProfilePicture(String newProfilePicture) {
    profilePicture = newProfilePicture;
  }

  // Method to update phone number
  void updatePhoneNumber(String newPhoneNumber) {
    phoneNumber = newPhoneNumber;
  }

  // Method to update role
  void updateRole(String newRole) {
    role = newRole;
  }

  // Method to display user information
  @override
  String toString() {
    return 'UserModel(id: $id, fullName: $fullName, email: $email, username: $username, phoneNumber: $phoneNumber, profilePicture: $profilePicture, role: $role, trainerDetails: $trainerDetails, clientDetails: $clientDetails)';
  }

  // Method to convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'username': username,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'role': role, // Include the role in toJson
      // Include clientDetails if not null
    };
  }

  // Method to create UserModel from Firestore document
  static Future<UserModel> fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) async {
    final data = document.data()!;
    final role = data['role'] ?? 'client';

    // Fetch trainerDetails from subcollection if the role is trainer
    if (role == 'trainer') {
      final trainerSnapshot = await FirebaseFirestore.instance
          .collection("Profiles")
          .doc(document.id)
          .collection("trainerDetails")
          .doc('details') // Assuming only one document for trainer details
          .get();
    }

    // Fetch clientDetails if the role is client

    return UserModel(
      id: document.id,
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      profilePicture: data['profilePicture'] ?? '',
      role: role,
    );
  }

  // Method to save trainer details to Firestore subcollection
}
