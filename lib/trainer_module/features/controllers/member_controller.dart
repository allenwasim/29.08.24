import 'package:get/get.dart';
import 'package:t_store/trainer_module/data/repositories/member_repository.dart';
import 'package:t_store/user_module/features/personalization/controllers/user_controller.dart';
import 'package:t_store/utils/popups/loader.dart';

class MemberController extends GetxController {
  // Singleton instance
  static MemberController get instance => Get.find();

  final MemberRepository repository = Get.put(MemberRepository());
  final UserController userController = Get.put(UserController());

  // Observables for active and expired members
  final RxInt activeMembers = 0.obs;
  final RxInt expiredMembers = 0.obs;
  final RxInt expired1To3Days = 0.obs;
  final RxInt expired4To7Days = 0.obs;
  final RxInt expired8To15Days = 0.obs;
  final RxInt expiringToday = 0.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Example: Fetch data on initialization
    fetchActiveAndExpiredMembers(userController.user.value.id);
  }

  // Fetch all membership details for a trainer
  Future<void> fetchActiveAndExpiredMembers(String trainerId) async {
    try {
      isLoading.value = true;
      final result =
          await repository.calculateActiveAndExpiredMembers(trainerId);

      activeMembers.value = result['active'] ?? 0;
      expiredMembers.value = result['expired'] ?? 0;

      // Calculate range-specific data
      final rangeData = await repository.calculateExpiredInRanges(trainerId);

      expired1To3Days.value = rangeData['1-3'] ?? 0;
      expired4To7Days.value = rangeData['4-7'] ?? 0;
      expired8To15Days.value = rangeData['8-15'] ?? 0;
      expiringToday.value = rangeData['today'] ?? 0;
    } catch (e) {
      print('Error in fetchActiveAndExpiredMembers: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
