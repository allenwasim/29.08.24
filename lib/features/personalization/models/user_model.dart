import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/utils/formatters/formatter.dart';

class UserModel {
  // Keep these values final which you do not want to update
  final String id;
  String firstName;
  String lastName;
  final String email;
  final String username;
  String phoneNumber;
  String profilePicture;

  // Constructor
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    this.phoneNumber = '',
    this.profilePicture = '',
  });

  // Named constructor for an empty user model
  UserModel.empty()
      : id = '',
        firstName = '',
        lastName = '',
        email = '',
        username = '',
        phoneNumber = '',
        profilePicture = '';

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

  // Method to display user information
  @override
  String toString() {
    return 'UserModel(id: $id, fullName: $fullName, email: $email, username: $username, phoneNumber: $phoneNumber, profilePicture: $profilePicture)';
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
    };
  }

  // Method to create UserModel from JSON
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data['firstName'] ?? '',
        lastName: data['lastName'] ?? '',
        username: data['username'] ?? '',
        email: data['email'] ?? '',
        phoneNumber: data['phoneNumber'] ?? '',
        profilePicture: data['profilePicture'] ?? '',
      );
    } else {
      throw Exception('Document data is null');
    }
  }

  // Method to create a unique username from full name
  static String createUsername(String fullName) {
    final names = fullName.split(' ');
    final firstName = names.isNotEmpty ? names[0] : 'user';
    final lastName = names.length > 1 ? names[1] : 'user';
    final random = Random();
    final randomNumber = random.nextInt(9999).toString().padLeft(4, '0');
    return '${firstName.toLowerCase()}_${lastName.toLowerCase()}_$randomNumber';
  }

  // copyWith method to create a copy of the UserModel with updated values
  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? username,
    String? phoneNumber,
    String? profilePicture,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      username: username ?? this.username,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }
}
