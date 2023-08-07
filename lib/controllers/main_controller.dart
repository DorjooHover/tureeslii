import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:landlord/controllers/auth_controller.dart';
import 'package:landlord/model/models.dart';
import 'package:landlord/provider/api_prodiver.dart';

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

  // add post
  final verified = <int>[0].obs;
  final currentStep = 0.obs;
  final createPost = Rxn<Post>(Post());
  User? get user => rxUser.value;
  set user(value) => rxUser.value = value;
  refreshUser() async {
    ErrorHandler res = await _apiRepository.getUser();

    if (res.success!) {
      user = res.data;
      change(user, status: RxStatus.success());
    } else {
      authController.logout();
    }
  }

  // create post
  nextStep() {
    if (verified.where((p0) => p0 == (currentStep.value + 1)).isEmpty &&
        currentStep.value < 6) {
      verified.add(currentStep.value + 1);
      currentStep.value = currentStep.value + 1;
    }
    print(createPost.value?.toJson());
  }

  Future<void> createNewPost(List<XFile> images) async {
    try {
      List<String> imagesUrl = [];
      for (final element in images) {
        imagesUrl.add(await _apiRepository.uploadFile(element));
      }
      print(imagesUrl);
      await _apiRepository.createPost(createPost.value!, imagesUrl);
    } catch (e) {
      print(e);
    }
  }

  Future<void> setupApp() async {
    refreshUser();
  }

  Future<bool> savePersonal(User u) async {
    bool res = await _apiRepository.savePersonal(User(
        lastname: u.lastname ?? user!.lastname,
        firstname: u.firstname ?? user!.firstname,
        mobile: u.mobile ?? user!.mobile!,
        companyName: u.companyName ?? user!.companyName,
        companyRegistry: u.companyRegistry ?? user!.companyRegistry,
        orderNotification: u.orderNotification ?? user!.orderNotification,
        productAdsNotification:
            u.productAdsNotification ?? user!.productAdsNotification));
    if (res) {
      refreshUser();
    }
    return res;
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
