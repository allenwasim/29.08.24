import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:t_store/trainer_module/data/repositories/membership_repository.dart';
import 'package:t_store/trainer_module/features/models/membership_model.dart';
import 'package:t_store/trainer_module/features/sections/gym/gym.dart';
import 'package:t_store/user_module/features/personalization/models/client_model.dart';
import 'package:t_store/user_module/features/personalization/screens/memberships/memberships.dart';
import 'package:t_store/user_module/features/personalization/screens/memberships/tabs/active/active.dart';
import 'package:t_store/utils/popups/loader.dart';

class MembershipController extends GetxController {
  static MembershipController get instance => Get.find();

  // Observable list to store the membership plans
  final membershipPlans = <MembershipModel>[].obs;
  var clientDetails = <ClientDetails>[].obs;

  // Observable variable to store the membership details
  final membershipDetails = <MembershipModel>[].obs;
  final RxList<String> membershipIds = <String>[].obs;
  RxList<MembershipModel> clientMemberships = <MembershipModel>[].obs;

  final Rx<MembershipModel> user = MembershipModel.empty().obs;
  var profileLoading = false.obs; // Loading state
  var availableMemberships =
      <MembershipModel>[].obs; // Observable list for memberships

  final RxList<dynamic> memberships = <dynamic>[].obs;
  final RxBool membershipsLoading = false.obs;

  final MembershipRepository membershipRepository =
      Get.put(MembershipRepository());
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  // Fetch membership plans by trainer ID
  Future<void> fetchMembershipPlans({required String trainerId}) async {
    try {
      isLoading.value = true;
      final fetchedPlans =
          await membershipRepository.fetchMembershipPlansByTrainer(trainerId);
      membershipPlans.value = fetchedPlans;
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      TLoaders.warningSnackBar(
        title: "Error",
        message: "Failed to fetch membership plans. Please try again.",
      );
    }
  }

  // Fetch membership details for a specific trainer
  Future<void> fetchAvailableMemberships() async {
    try {
      profileLoading.value = true;
      // Call the repository function to fetch the available memberships
      availableMemberships.value =
          await membershipRepository.fetchAvailableMembershipsFromFirestore();
      await Future.delayed(Duration(milliseconds: 100)); // Slight delay
    } catch (e) {
      availableMemberships.value = []; // Reset on error
      print('Error fetching available membership plans: $e');
    } finally {
      profileLoading.value = false; // Ensure this is always set to false
    }
  }

  Future<void> addMembershipByUser({
    required String userId,
    required String membershipId,
    required Timestamp startDate,
    required String status,
    required int progress,
    required int duration,
  }) async {
    try {
      // Log for debugging
      print('Initiating membership addition for user: $userId');

      // Call the repository method to perform the Firestore update for the user
      await membershipRepository.addMembershipByUser(
        userId: userId,
        membershipId: membershipId,
        startDate: startDate,
        status: status,
        progress: progress,
        duration: duration,
      );

      // Call the repository method to add the membership to the trainer

      // Navigate to the Memberships page
      Get.to(() => Memberships());

      // Optionally handle success in the UI
      print('Membership added successfully for User ID: $userId');
    } catch (e) {
      print('Error in adding membership for user $userId: $e');
      throw Exception('Failed to add membership');
    }
  }

  Future<void> findMembershipsByClientId(String clientId) async {
    try {
      // Set loading state to true while fetching data
      isLoading.value = true;

      // Fetch memberships for the given clientId from the repository
      List<Map<String, dynamic>> membershipsData =
          await membershipRepository.fetchMembershipsByClientId(clientId);

      // Check if the fetched data is not empty
      if (membershipsData.isEmpty) {
        print('No memberships found for clientId $clientId');
      }

      // Convert the fetched list of maps into a list of MembershipModel instances
      clientMemberships.value = membershipsData.map((data) {
        // Map each item to the MembershipModel (ensure the fields are mapped correctly)
        return MembershipModel.fromMap(data);
      }).toList();

      print('Fetched memberships for clientId $clientId: $clientMemberships');
    } catch (e) {
      print('Error fetching memberships for clientId $clientId: $e');
      throw Exception('Failed to fetch memberships for client');
    } finally {
      // Set loading state to false after the operation completes
      isLoading.value = false;
    }
  }

  Future<void> addMemberToTrainer(
    String trainerId,
    String clientId,
    String membershipId,
    String profilePic,
  ) async {
    try {
      // Call the repository method to add the member to the trainer's list
      await membershipRepository.addMemberToTrainer(
        trainerId,
        clientId,
        membershipId,
        profilePic,
      );
      // Optionally handle success UI logic here, e.g., showing a success message
      print('Successfully added member to trainer.');
    } catch (e) {
      // Handle failure UI logic here, e.g., showing an error message
      print('Failed to add member to trainer: $e');
    }
  }

  Future<void> fetchMembershipDetails(String trainerId) async {
    try {
      isLoading.value = true; // Set loading to true
      final fetchedMemberships =
          await membershipRepository.getMembershipDetailsForTrainer(trainerId);

      // Convert List<Map<String, dynamic>> to List<MembershipModel>
      membershipDetails.value = fetchedMemberships
          .map((membershipMap) => MembershipModel.fromMap(membershipMap))
          .toList();

      isLoading.value = false; // Set loading to false
    } catch (e) {
      isLoading.value = false;
      print('Error fetching membership details: $e');
      throw Exception("Error fetching membership details: $e");
    }
  }

  Future<void> fetchClientDetailsForTrainer(String trainerId) async {
    try {
      profileLoading.value = true; // Setting the loading state to true
      final fetchedClientDetails =
          await membershipRepository.getClientDetailsForTrainer(trainerId);

      clientDetails.assignAll(
        fetchedClientDetails
            .map((data) =>
                ClientDetails.fromMap(data)) // Now with memberships included
            .toList(),
      );
    } catch (e) {
      print('Error fetching client details: $e');
      clientDetails.clear(); // Optionally clear the list if there's an error
    } finally {
      profileLoading.value = false; // Setting the loading state to false
    }
  }
}
