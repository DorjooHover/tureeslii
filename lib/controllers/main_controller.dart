import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tureeslii/controllers/auth_controller.dart';
import 'package:tureeslii/model/models.dart';
import 'package:tureeslii/provider/api_prodiver.dart';
import 'package:tureeslii/routes.dart';
import 'package:tureeslii/shared/index.dart';

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
  final savedPosts = <Post>[].obs;
  final city = cities[0].obs;
  final timeType = byMonth.obs;

  // otp
  final otp = "------".obs;

  // change password
  final oldPassword = "".obs;
  final newPassword = "".obs;
  final confirmPassword = "".obs;
// category
  final allCategory = <Category>[].obs;
  // posts
  final allPosts = <Post>[].obs;
  // own posts
  final myRentRequest = <RentRequest>[].obs;

  // rent request
  final startDate = ''.obs;
  final endDate = ''.obs;
  final duration = 1.obs;

  User? get user => rxUser.value;
  set user(value) => rxUser.value = value;
// orders
  Future<void> getOrders() async {
    try {
      List<RentRequest> res =
          await apiRepository.getMyRentRequest(0, 10, SortData(), []);
      myRentRequest.value = res;
      print(res);
    } catch (e) {
      print(e);
    }
  }

  // posts

  getAllPosts(int page, int limit, SortData sortData,
      List<FilterData> filterData) async {
    try {
      final res = await apiRepository.getAllPosts(
        page,
        limit,
        sortData,
        filterData,
      );
      allPosts.value = res;

      return res;
    } on DioException catch (e) {
      print(e);
    }
  }

  getPostPriceRange(FilterData filterData) async {
    return await apiRepository.getPriceRange(filterData);
  }

  // saved posts
  getSavedPost() async {
    if (user != null) {
      try {
        final res = await apiRepository.getSavedPosts();
        savedPosts.value = res;

        return res;
      } on DioException catch (e) {
        print(e);
      }
    }
  }

  Future<bool> togglePost({required int id, Post? post}) async {
    try {
      bool result = false;

      if (user != null) {
        if (savedPosts.where((post) => post.id == id).isNotEmpty) {
          savedPosts.removeWhere((element) => element.id == id);
          await apiRepository.removeBookmark(id);
          getSavedPost();
        } else {
          if (post != null && post.id != null) {
            savedPosts.add(post);
            await apiRepository.saveBookmark(id);
            result = true;
            getSavedPost();
          }
        }
      }

      return result;
    } on DioException {
      rethrow;
    }
  }

  Future<bool> rentRequest(
      int postId, String startDate, int duration, String type) async {
    try {
      ErrorHandler res =
          await apiRepository.rentRequest(postId, startDate, duration, type);
      if (!res.success!) {
        return false;
      }
      return res.success!;
    } on Exception {
      return false;
    }
  }

// profile
  Future<bool> changePassword() async {
    try {
      if (newPassword.value == confirmPassword.value) {
        await apiRepository.changePassword(
            oldPassword.value, newPassword.value);
        return true;
      } else {
        
        return false;
      }
    } on DioException catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateUser(User user) async {
    final res = await apiRepository.updateUser(user);
    if (res) {
      await refreshUser();
    }
    return res;
  }

  Future<bool> savePersonal(
      String lastname, String firstname, String phone) async {
    bool res = await apiRepository.savePersonal(lastname, firstname, phone);
    if (res) {
      refreshUser();
    }
    return res;
  }

  refreshUser() async {
    user = await apiRepository.getUser();
    change(user, status: RxStatus.success());
  }

  Future<void> setupApp() async {
    isLoading.value = true;
    if (storage.read(StorageKeys.token.name) != null) {
      try {
        final res = await apiRepository.getUser();
        if (res != null) {
          user = res;
          change(user, status: RxStatus.success());
        }
        allCategory.value = await apiRepository.getCategories();
        getSavedPost();

        isLoading.value = false;
      } on DioException {
        isLoading.value = false;

        storage.remove(StorageKeys.token.name);
        update();
        Get.toNamed(Routes.auth);
      }
    }
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
