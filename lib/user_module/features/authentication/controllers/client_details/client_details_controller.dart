import 'package:get/get.dart';
import 'package:t_store/user_module/data/repositories/client/client_repository.dart';
import 'package:t_store/utils/popups/loader.dart';

class ClientDetailsController extends GetxController {
  static ClientDetailsController get instance => Get.find();

  final Rx<Map<String, dynamic>?> clientDetails =
      Rx<Map<String, dynamic>?>(null);
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
      detailsLoading.value = true;
      final fetchedDetails =
          await clientRepository.fetchClientDetails(clientId);
      clientDetails.value = fetchedDetails; // Update the client details
      detailsLoading.value = false;
    } catch (e) {
      clientDetails.value = null; // Handle any error
      detailsLoading.value = false;
      TLoaders.warningSnackBar(
          title: "Error",
          message: "Failed to fetch client details. Please try again.");
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
