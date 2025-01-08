import 'package:get/get.dart';
import 'package:t_store/user_module/data/repositories/client/client_repository.dart';
import 'package:t_store/user_module/features/personalization/models/client_model.dart';
import 'package:t_store/utils/popups/loader.dart';

class ClientDetailsController extends GetxController {
  static ClientDetailsController get instance => Get.find();

  Rx<ClientDetails?> clientDetails = Rx<ClientDetails?>(null);

  final clientRepository = Get.put(ClientRepository());
  final detailsLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchClientDetails(
        "someClientId"); // You can replace "someClientId" with actual client ID
  }

  // Function to fetch client details
  Future<void> fetchClientDetails(String clientId) async {
    try {
      detailsLoading.value = true; // Indicate loading state
      final fetchedDetails =
          await clientRepository.fetchClientDetails(clientId);

      if (fetchedDetails != null && fetchedDetails.isNotEmpty) {
        // Convert the fetched map to a ClientDetails instance
        clientDetails.value = ClientDetails.fromMap(fetchedDetails);
      } else {
        clientDetails.value = null; // Handle empty details
        TLoaders.warningSnackBar(
          title: "No Data",
          message: "No client details were found for the provided ID.",
        );
      }
    } catch (e) {
      clientDetails.value = null; // Reset client details on error
      TLoaders.warningSnackBar(
        title: "Error",
        message: "Failed to fetch client details. Please try again.",
      );
      print("Error fetching client details: $e"); // Log the error
    } finally {
      detailsLoading.value = false; // Always reset loading state
    }
  }

  // Function to save client details
  Future<void> saveClientDetails(
      String clientId, Map<String, dynamic> clientDetailsMap) async {
    try {
      await clientRepository.saveClientDetails(clientId, clientDetailsMap);
      TLoaders.successSnackBar(
          title: "Success", message: "Client details saved successfully.");
    } catch (e) {
      TLoaders.warningSnackBar(
          title: "Error",
          message: "Failed to save client details. Please try again.");
    }
  }
}
