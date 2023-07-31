import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:landlord/controllers/auth_controller.dart';
import 'package:landlord/model/models.dart';
import 'package:landlord/provider/api_prodiver.dart';
import 'package:landlord/shared/constants/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainController extends GetxController
    with StateMixin<User>, WidgetsBindingObserver {
  final ApiRepository _apiRepository = Get.find();
  final authController = Get.put(AuthController(apiRepository: Get.find()));

  final showPerformanceOverlay = false.obs;
  final currentIndex = 0.obs;
  final isLoading = false.obs;
  final rxUser = Rxn<User?>();
  final currentUserType = 'user'.obs;
  final our = false.obs;
  final loading = false.obs;

  User? get user => rxUser.value;
  set user(value) => rxUser.value = value;

  getUser(User user) {
    change(user, status: RxStatus.success());
    update();
  }

  Future<void> setupApp() async {
    isLoading.value = true;
    try {
      user = await _apiRepository.getUser();
      change(user, status: RxStatus.success());

      isLoading.value = false;
    } on DioError catch (e) {
      isLoading.value = false;

      Get.find<SharedPreferences>().remove(StorageKeys.token.name);
      update();
    }
  }

  // changeOrderStatus(String id, String status) {
  //   Map data = {"id": id, "status": status};
  //   socket.emit('change_order_status', data);
  // }

  @override
  void onInit() async {
    await setupApp();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  onReady() {
    super.onReady();
  }
}
