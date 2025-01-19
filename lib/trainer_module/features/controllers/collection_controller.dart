import 'package:get/get.dart';
import 'package:t_store/trainer_module/data/repositories/collection_repository.dart';
import 'package:t_store/user_module/features/personalization/controllers/user_controller.dart';
import 'package:t_store/utils/popups/loader.dart';

class CollectionController extends GetxController {
  static CollectionController get instance => Get.find();

  final CollectionRepository collectionRepository =
      Get.put(CollectionRepository());
  final UserController userController = Get.put(UserController());

  final RxDouble totalCollection = 0.0.obs;
  final RxDouble monthlyCollection = 0.0.obs;
  final RxDouble totalCollectionForDateRange =
      0.0.obs; // Added for date range collection
  final RxDouble todaysCollection = 0.0.obs;

  final isLoading = false.obs;

  /// Fetch total earnings (collection) for a trainer
  Future<void> fetchTotalCollection() async {
    try {
      isLoading.value = true;
      final trainerId = userController.user.value.id;
      final total = await collectionRepository.fetchTotalCollection(trainerId);
      totalCollection.value = total;
    } catch (e) {
      print("Error fetching total collection: $e");
      TLoaders.warningSnackBar(
        title: "Fetch Failed",
        message: "Unable to fetch total collection. Please try again.",
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Fetch monthly earnings (collection) for a trainer
  Future<void> fetchMonthlyCollection(int year, int month) async {
    try {
      isLoading.value = true;
      final trainerId = userController.user.value.id;
      final monthly = await collectionRepository.fetchMonthlyCollection(
          trainerId, year, month);
      monthlyCollection.value = monthly;
    } catch (e) {
      print("Error fetching monthly collection: $e");
      TLoaders.warningSnackBar(
        title: "Fetch Failed",
        message: "Unable to fetch monthly collection. Please try again.",
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Example method to fetch both total and monthly collections together
  Future<void> fetchAllCollections(int year, int month) async {
    try {
      isLoading.value = true;
      final trainerId = userController.user.value.id;
      await Future.wait([
        fetchTotalCollection(), // Fetch total collection using the trainerId from userController
        fetchMonthlyCollection(year,
            month), // Fetch monthly collection using the trainerId from userController
      ]);
    } catch (e) {
      print("Error fetching collections: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Fetch collections (earnings) between a date range
  Future<void> fetchCollectionsBetweenDates(
      DateTime fromDate, DateTime toDate) async {
    try {
      isLoading.value = true;
      final total = await collectionRepository.fetchCollectionsBetweenDates(
        userController.user.value.id, // Assuming you need the trainerId here
        fromDate,
        toDate,
      );

      totalCollectionForDateRange.value =
          total; // Set the total collection for the date range
      monthlyCollection.value =
          total; // Optionally use total for monthly earnings as well
    } catch (e) {
      print("Error fetching collections for date range: $e");
      TLoaders.warningSnackBar(
        title: "Fetch Failed",
        message: "Unable to fetch collections. Please try again.",
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchTodaysCollection() async {
    try {
      isLoading.value = true;
      final trainerId = userController.user.value.id;

      // Get today's date
      final today = DateTime.now();

      // Call repository method to fetch today's collection
      final todaysTotal = await collectionRepository.fetchCollectionForDate(
        trainerId,
        today, // Pass today's date
      );

      todaysCollection.value = todaysTotal;
    } catch (e) {
      print("Error fetching today's collection: $e");
      TLoaders.warningSnackBar(
        title: "Fetch Failed",
        message: "Unable to fetch today's collection. Please try again.",
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Reset collections data
  void resetCollections() {
    totalCollection.value = 0.0;
    monthlyCollection.value = 0.0;
    totalCollectionForDateRange.value =
        0.0; // Reset total for the selected date range
  }
}
