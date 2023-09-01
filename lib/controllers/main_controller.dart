import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:landlord/controllers/auth_controller.dart';
import 'package:landlord/model/models.dart';
import 'package:landlord/provider/api_prodiver.dart';
import 'package:landlord/routes.dart';
import 'package:landlord/shared/constants/enums.dart';

class MainController extends GetxController
    with StateMixin<User>, WidgetsBindingObserver {
  ApiRepository apiRepository = ApiRepository();
  final authController = Get.put(AuthController());
  final storage = GetStorage();
  final showPerformanceOverlay = false.obs;
  final currentIndex = 0.obs;
  final isLoading = false.obs;
  final rxUser = Rxn<User?>();
  final currentUserType = 'user'.obs;
  final our = false.obs;
  final loading = false.obs;
  final allCategory = <Category>[].obs;
  // config
  final banks = <String>[].obs;
  final cities = <City>[].obs;
  // cancel term
  final cancelTerm = <Cancelation>[].obs;
// otp
  final otp = "------".obs;
  // add post
  final verified = <int>[0].obs;
  final currentStep = 0.obs;
  final createPost = Rxn<Post>(Post());

  // own post
  final ownPost = <Post>[].obs;
  User? get user => rxUser.value;
  set user(value) => rxUser.value = value;

  // config
  getBanks() async {
    final res = await apiRepository.getConfigById('banks');
    banks.value = List<String>.from(jsonDecode(res.value!) as List);
  }

  Future<void> getCities() async {
    final res = await apiRepository.getConfigById('cities');
    cities.value =
        (jsonDecode(res.value!) as List).map((e) => City.fromJson(e)).toList();
  }

  getCancellation() async {
    final res = await apiRepository.getCancelation();
    cancelTerm.value = res;
  }

  // user
  refreshUser() async {
    user = await apiRepository.getUser();
    change(user, status: RxStatus.success());
  }

  Future<bool> updateUser(User user) async {
    final res = await apiRepository.updateUser(user);
    if (res) {
      await refreshUser();
    }
    return res;
  }

  Future<void> sendEmailVerification() async {
    await apiRepository.sendEmailVerifyCode();
  }

  Future<bool> getMobileVerification() async {
    return apiRepository.getMobileVerifyCode();
  }

  Future<bool> sendMobileVerification() async {
    return apiRepository.sendMobileVerifyCode(otp.value);
  }

  Future<bool> savePersonal(User u) async {
    bool res = await apiRepository.savePersonal(User(
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

  sendVerificationUser(XFile frontImage, XFile backImage, String bankName,
      String accountNumber, String accountName) async {
    try {
      final regex = RegExp(r'^[0-9a-zA-Zа-яА-ЯҮүӨө]');
      bool r = regex.hasMatch(accountName);

      if (r) {
        String front = await apiRepository.uploadFile(frontImage);
        String back = await apiRepository.uploadFile(backImage);
        final res = await apiRepository.verificationUser(
            front, back, accountNumber, bankName, accountName);
        return res;
      }
    } catch (e) {
      print(e);
    }
  }

  // create post
  nextStep() {
    if (verified.where((p0) => p0 == (currentStep.value + 1)).isEmpty &&
        currentStep.value < 6) {
      verified.add(currentStep.value + 1);
      currentStep.value = currentStep.value + 1;
    }
  }

  prevStep() {
    if (currentStep.value > 0) {
      currentStep.value = currentStep.value - 1;
    }
  }

  Future<void> createNewPost(List<XFile> images) async {
    try {
      List<String> imagesUrl = [];
      for (final element in images) {
        imagesUrl.add(await apiRepository.uploadFile(element));
      }

      await apiRepository
          .createPost(createPost.value!, imagesUrl)
          .then((value) => createPost.value = Post());
    } catch (e) {
      print(e);
    }
  }

  // own post
  Future<void> getOwnPost(SortData? sortData, List<FilterData> filterData,
      [int skip = 0, int take = 10]) async {
    try {
      ownPost.value =
          await apiRepository.getOwnPosts(skip, take, sortData, filterData);
    } catch (e) {
      print(e);
    }
  }

  Future<void> setupApp() async {
    isLoading.value = true;
    try {
      final res = await apiRepository.getUser();
      if (res != null) {
        user = res;
        change(user, status: RxStatus.success());
        if (user != null) {
          getBanks();
          getCities();
          getCancellation();
          allCategory.value = await apiRepository.getCategories();
          getOwnPost(null, []);

          // getSavedPost();
        }
      }

      isLoading.value = false;
    } on DioException {
      isLoading.value = false;

      storage.remove(StorageKeys.token.name);
      update();
      Get.toNamed(Routes.auth);
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
