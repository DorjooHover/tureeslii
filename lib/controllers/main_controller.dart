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
import 'package:landlord/shared/constants/strings.dart';
import "dart:developer" as dev;

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
  // verification
  final verification = Rxn<Verification?>();
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

  // order
  final orders = <Post>[].obs;
  // config
  getBanks() async {
    try {
      final res = await apiRepository.getConfigById('banks');
      res.fold((l) => null,
          (r) => banks.value = List<String>.from(jsonDecode(r.value!) as List));
    } catch (e) {
      dev.log(e.toString());
    }
  }

  getVerification() async {
    try {
      final res = await apiRepository.getUserVerification();
      res.fold((l) => null, (r) => verification.value = r);
    } catch (e) {
      dev.log(e.toString());
    }
  }

  Future<void> getCities() async {
    try {
      final res = await apiRepository.getConfigById('cities');
      res.fold(
          (l) => null,
          (r) => cities.value = (jsonDecode(r.value!) as List)
              .map((e) => City.fromJson(e))
              .toList());
    } catch (e) {
      dev.log(e.toString());
    }
  }

  Future<void> getCancellation() async {
    try {
      final res = await apiRepository.getCancelation();
      res.fold((l) => null, (r) => cancelTerm.value = r);
    } catch (e) {
      dev.log(e.toString());
    }
  }

  getCategories() async {
    try {
      final res = await apiRepository.getCategories();
      res.fold((l) => null, (r) => allCategory.value = r);
    } catch (e) {
      dev.log(e.toString());
    }
  }

  // user
  refreshUser() async {
    user = await apiRepository.getUser();
    change(user, status: RxStatus.success());
  }

  updateUser(User user) async {
    final res = await apiRepository.updateUser(user);
    res.fold((l) => null, (r) => refreshUser());
  }

  Future<void> sendEmailVerification() async {
    await apiRepository.sendEmailVerifyCode();
  }

  getMobileVerification() async {
    final res = await apiRepository.getMobileVerifyCode();
    res.fold((l) => null, (r) => null);
  }

  sendMobileVerification() async {
    final res = await apiRepository.sendMobileVerifyCode(otp.value);
    res.fold((l) => null, (r) => null);
  }

  savePersonal(User u) async {
    final res = await apiRepository.savePersonal(User(
        lastname: u.lastname ?? user!.lastname,
        firstname: u.firstname ?? user!.firstname,
        mobile: u.mobile ?? user!.mobile!,
        companyName: u.companyName ?? user!.companyName,
        companyRegistry: u.companyRegistry ?? user!.companyRegistry,
        orderNotification: u.orderNotification ?? user!.orderNotification,
        productAdsNotification:
            u.productAdsNotification ?? user!.productAdsNotification));
    res.fold((l) => null, (r) => refreshUser());
  }

  sendVerificationUser(XFile? frontImage, XFile? backImage, String bankName,
      String accountNumber, String accountName) async {
    try {
      final regex = RegExp(r'^[0-9a-zA-Zа-яА-ЯҮүӨө]');
      bool r = regex.hasMatch(accountName);
      bool result = false;
      if (r) {
        bool check = true;
        String? frontRes, backRes;
        if (frontImage != null) {
          final front = await apiRepository.uploadFile(frontImage);
          front.fold((l) => check = false, (r) => frontRes = r);
        }
        if (check) {
          final back = await apiRepository.uploadFile(backImage);
          back.fold((l) => check = false, (r) => backRes = r);
        }
        if (check) {
          final res = await apiRepository.verificationUser(
              frontRes == null ? verification.value!.front! : frontRes!,
              backRes == null ? verification.value!.back! : backRes!,
              accountNumber,
              bankName,
              accountName,
              verification.value != null);
          res.fold((l) => print(l), (r) => result = r);
        }
      }
      return result;
    } catch (e) {
      dev.log(e.toString());
    }
  }

  Future<Map<String, List>> getPostStats(String postId, String date) async {
    Map<String, List>? f;
    final res = await apiRepository.getPostStats(postId, date);
    res.fold((l) => f = {}, (r) => f = r);
    return f!;
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
        final res = await apiRepository.uploadFile(element);
        res.fold((l) => null, (r) => imagesUrl.add(r));
      }

      await apiRepository
          .createPost(createPost.value!, imagesUrl)
          .then((value) => createPost.value = Post());
    } catch (e) {
      dev.log(e.toString());
    }
  }

  // update post

  Future<bool> updatePost(List<XFile> images) async {
    try {
      List<String> imagesUrl = [];
      bool success = false;
      if (images.isNotEmpty) {
        for (final element in images) {
          final res = await apiRepository.uploadFile(element);
          res.fold((l) => null, (r) => imagesUrl.add(r));
        }
      }
      final res = await apiRepository.updatePost(createPost.value!, imagesUrl);
      res.fold((l) => null, (r) => success = r);
      return success;
    } catch (e) {
      return false;
    }
  }

  // delete post
  Future<ErrorHandler> deletePost(String id) async {
    final res = await apiRepository.deletePost(id);
    ErrorHandler? handler;
    res.fold(
        (l) => handler = ErrorHandler(success: false, message: errorOccurred),
        (r) => handler = r);

    return handler!;
  }

  // own post
  Future<void> getOwnPost(SortData? sortData, List<FilterData> filterData,
      [int skip = 0, int take = 10]) async {
    try {
      final res =
          await apiRepository.getOwnPosts(skip, take, sortData, filterData);
      res.fold((l) => null, (r) => ownPost.value = r);
    } catch (e) {
      dev.log(e.toString());
    }
  }

  // order
  Future<void> getOrder(SortData? sortData, List<FilterData> filterData,
      [int skip = 0, int take = 10]) async {
    try {
      final res =
          await apiRepository.getMyOrders(skip, take, sortData, filterData);
      res.fold((l) => null, (r) => ownPost.value = r);
    } catch (e) {
      dev.log(e.toString());
    }
  }

  // rent request
  Future<List<RentRequest>> getRentRequestById(int id) async {
    try {
      List<RentRequest> list = [];
      final res = await apiRepository.getRentRequestById(id);
      res.fold((l) => null, (r) => list = r);
      return list;
    } catch (e) {
      return [];
    }
  }

  // pendingRentRequest
  Future<List<RentRequest>> pendingRentRequest(String status) async {
    try {
      List<RentRequest> list = [];
      final res = await apiRepository.pendingRentRequest(status);
      res.fold((l) => null, (r) => list = r);
      return list;
    } catch (e) {
      dev.log(e.toString());
      return [];
    }
  }

  Future<void> setupApp() async {
    isLoading.value = true;
    final token = storage.read(StorageKeys.token.name);
    if (token == null) {
      return;
    }
    try {
      final res = await apiRepository.getUser();
      res.fold(
          (l) => null,
          (r) => {
                user = r,
                change(user, status: RxStatus.success()),
                if (user != null)
                  {
                    getBanks(),
                    getCities(),
                    getCancellation(),
                    getCategories(),
                    getOwnPost(null, [])

                    // getSavedPost();
                  }
              });

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
