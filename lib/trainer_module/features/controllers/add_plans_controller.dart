import 'package:get/get.dart';
import 'package:t_store/trainer_module/data/repositories/membership_repository.dart';
import 'package:t_store/trainer_module/features/models/membership_model.dart';
import 'package:t_store/trainer_module/features/sections/gym/gym.dart';

class AddPlansController extends GetxController {
  final MembershipRepository membershipRepository =
      Get.put(MembershipRepository()); // Use Get.find() here

  RxString name = ''.obs;
  RxString description = ''.obs;
  RxDouble price = 0.0.obs;
  RxInt duration = 0.obs; // Changed from RxString to RxInt
  RxList<String> workouts = <String>[].obs;
  RxBool isAvailable = true.obs;

  RxList<MembershipModel> membershipPlans = <MembershipModel>[].obs;

  final List<String> availableWorkouts = [
    "Calisthenics",
    "Weight Training",
    "Endurance",
    "Boxing",
    "Overall Fitness",
    "Yoga",
    "Animal Movement"
  ];

  // Function to add the membership plan
  Future<void> addMembershipPlan(String trainerId) async {
    if (name.value.isEmpty ||
        description.value.isEmpty ||
        price.value <= 0 ||
        duration.value <= 0) {
      // Check if duration is valid
      Get.snackbar(
        'Error',
        'Please fill in all fields correctly.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      // Call the repository to save the membership plan
      MembershipModel newPlan = await membershipRepository.addMembershipPlan(
        trainerId,
        name.value,
        description.value,
        price.value,
        duration.value, // Convert duration to string
        workouts,
        isAvailable.value,
      );

      // Show success snackbar
      Get.snackbar(
        'Success',
        'Membership plan added successfully!',
        snackPosition: SnackPosition.BOTTOM,
      );

      // Navigate to another screen after adding the plan
      Get.offAll(() => GymScreen(
          trainerId: trainerId)); // Replace with the actual route name
    } catch (e) {
      // Show error snackbar
      Get.snackbar(
        'Error',
        'Failed to add membership plan. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Function to fetch all membership plans for the trainer
  Future<void> fetchMembershipPlans(String trainerId) async {
    try {
      List<MembershipModel> plans =
          await membershipRepository.fetchMembershipPlansByTrainer(trainerId);
      membershipPlans.value = plans; // Update the observable list
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch membership plans. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
