import 'package:get/get.dart';
import 'package:tureeslii/controllers/auth_controller.dart';
import 'package:tureeslii/model/models.dart';
import 'package:tureeslii/provider/api_prodiver.dart';

class NotificationController extends GetxController {
  final ApiRepository _apiRepository = Get.find();
  final authController = Get.put(AuthController(apiRepository: Get.find()));

  final showPerformanceOverlay = false.obs;
  final currentIndex = 0.obs;
  final isLoading = false.obs;
  final rxUser = Rxn<User?>();
  final currentUserType = 'user'.obs;
  final our = false.obs;
  final loading = false.obs;
  final savedPosts = <Post>[].obs;
  User? get user => rxUser.value;
  set user(value) => rxUser.value = value;
}
