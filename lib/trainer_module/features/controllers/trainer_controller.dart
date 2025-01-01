import 'package:get/get.dart';
import 'package:t_store/trainer_module/data/repositories/trainer_repository.dart';
import 'package:t_store/trainer_module/features/models/trainer_model.dart';

class TrainerDetailsController extends GetxController {
  // Define observable variables for loading and trainer data
  Rx<TrainerDetails?> trainer = Rx<TrainerDetails?>(null);
  RxBool profileLoading = RxBool(false);

  static TrainerDetailsController get instance => Get.find();
  final TrainerRepository trainerRepository = Get.put(TrainerRepository());

  // Fetch Trainer Details from the repository
  Future<void> fetchTrainerDetails(String trainerId) async {
    try {
      profileLoading.value = true;

      // Fetch trainer details using trainerId
      final fetchedTrainer =
          await TrainerRepository.instance.fetchTrainerDetails(trainerId);

      // Convert the fetched map into a TrainerDetails object
      if (fetchedTrainer != null) {
        trainer.value = TrainerDetails.fromJson(fetchedTrainer);
      } else {
        trainer.value = null;
      }

      profileLoading.value = false;
    } catch (e) {
      trainer.value = null; // Handle error case
      profileLoading.value = false;
      print('Error fetching trainer details: $e');
    }
  }

  // Save Trainer Details using TrainerRepository
  Future<void> saveTrainerDetails(
      String userId, Map<String, dynamic> trainerDetails) async {
    try {
      await trainerRepository.saveTrainerDetails(userId, trainerDetails);
    } catch (e) {
      // Handle error (optional: show a message)
    }
  }
}
