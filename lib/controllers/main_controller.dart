import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:landlord/controllers/auth_controller.dart';
import 'package:landlord/model/models.dart';
import 'package:landlord/provider/api_provider.dart';
import 'package:landlord/routes.dart';
import 'package:landlord/shared/constants/enums.dart';
import 'package:landlord/shared/constants/strings.dart';
import 'package:landlord/shared/constants/values.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import "dart:developer" as dev;
import 'package:top_snackbar_flutter/top_snack_bar.dart';

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
  final fetchLoading = false.obs;
  final loading = false.obs;
  final allCategory = <Category>[].obs;
  final imageFiles = <XFile>[].obs;
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

  Future<void> getVerification() async {
    try {
      final res = await apiRepository.getUserVerification();
      res.fold(
          (l) => null,
          (r) => {
                verification.value = r,
              });
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
    final token = storage.read(StorageKeys.token.name);
    if (token == null) {
      return;
    }

    try {
      final res = await apiRepository.getUser();
      res.fold(
          (l) async => {
                await storage.remove(StorageKeys.token.name),
                update(),
                Get.toNamed(Routes.auth)
              },
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
    } catch (e) {
      isLoading.value = false;

      storage.remove(StorageKeys.token.name);
      update();
      Get.toNamed(Routes.auth);
    }
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

  savePersonal(User u, BuildContext context) async {
    try {
      fetchLoading.value = false;
      final res = await apiRepository.savePersonal(User(
          lastname: u.lastname ?? user!.lastname,
          firstname: u.firstname ?? user!.firstname,
          mobile: u.mobile ?? user!.mobile!,
          companyName: u.companyName ?? user!.companyName,
          companyRegistry: u.companyRegistry ?? user!.companyRegistry,
          orderNotification: u.orderNotification ?? user!.orderNotification,
          productAdsNotification:
              u.productAdsNotification ?? user!.productAdsNotification));
      res.fold(
          (l) => showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.info(message: l),
              ), (r) {
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(message: Messages.success),
        );
        refreshUser();
      });
      fetchLoading.value = false;
    } catch (e) {
      fetchLoading.value = false;
      dev.log(e.toString());
    }
  }

  sendVerificationUser(XFile? frontImage, XFile? backImage, String bankName,
      String accountNumber, String accountName, BuildContext context) async {
    try {
      fetchLoading.value = true;
      final regex = RegExp(r'^[0-9a-zA-Zа-яА-ЯҮүӨө]');
      bool r = regex.hasMatch(accountName);

      if (r) {
        bool check = true;
        String? frontRes, backRes;
        if (frontImage != null) {
          final front = await apiRepository.uploadFile(frontImage);
          front.fold((l) => check = false, (r) => frontRes = r);
        }
        if (check && backImage != null) {
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
            verification.value?.status,
            verification.value != null,
          );
          res.fold(
              (l) => showTopSnackBar(
                    Overlay.of(context),
                    CustomSnackBar.info(message: l),
                  ),
              (r) => showTopSnackBar(
                    Overlay.of(context),
                    CustomSnackBar.success(message: Messages.success),
                  ));
        }
      }
      fetchLoading.value = false;
    } catch (e) {
      fetchLoading.value = false;
      dev.log(e.toString());
    }
  }

  Future<Map<String, List>> getPostStats(String postId, String date) async {
    Map<String, List>? f;
    final res = await apiRepository.getPostStats(postId, date);
    res.fold((l) => f = {}, (r) => {print(r), f = r});
    return f!;
  }

  // create post
  nextStep(
    bool success,
    BuildContext context,
    String message,
  ) {
    if (!success) {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.info(message: message),
      );
      return;
    }
    if (verified.where((p0) => p0 == (currentStep.value + 1)).isEmpty &&
        currentStep.value < 6) {
      verified.add(currentStep.value + 1);
    }
    currentStep.value = currentStep.value + 1;

    Get.toNamed(postStepsValue[currentStep.value]);
  }

  prevStep() {
    if (currentStep.value > 0) {
      currentStep.value = currentStep.value - 1;
    }

    Get.back();
  }

  createNewPost(BuildContext context) async {
    try {
      fetchLoading.value = true;
      List<String> imagesUrl = [];
      if (createPost.value!.postAttachments != null &&
          createPost.value!.postAttachments!.isNotEmpty) {
        imagesUrl = createPost.value!.postAttachments!
            .map((e) => e.fileThumb!)
            .toList();
      }
      for (final element in imageFiles) {
        final res = await apiRepository.uploadFile(element);
        res.fold((l) => print(l), (r) => imagesUrl.add(r));
      }

      final res = await apiRepository.createPost(createPost.value!, imagesUrl);
      res.fold(
          (l) => showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.info(message: l),
              ), (r) {
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(message: Messages.success),
        );
        createPost.value = Post();
        Get.toNamed(Routes.myAds);
      });
      fetchLoading.value = false;
    } catch (e) {
      fetchLoading.value = false;
      dev.log(e.toString());
    }
  }

  // update post

  updatePost(BuildContext context) async {
    try {
      List<String> imagesUrl = [];
      fetchLoading.value = true;
      if (imageFiles.isNotEmpty) {
        for (final element in imageFiles) {
          final res = await apiRepository.uploadFile(element);
          res.fold((l) => null, (r) => imagesUrl.add(r));
        }
      }

      final res = await apiRepository.updatePost(createPost.value!, imagesUrl);
      res.fold(
          (l) => showTopSnackBar(
                Overlay.of(context),
                const CustomSnackBar.info(message: tryAgain),
              ),
          (r) => showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.success(message: Messages.success),
              ));
      fetchLoading.value = false;
    } catch (e) {
      fetchLoading.value = false;
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.info(message: errorOccurred),
      );
    }
  }

  // delete post
  deletePost(String id, BuildContext context) async {
    final res = await apiRepository.deletePost(id);

    res.fold(
        (l) => showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.info(message: l),
            ), (r) {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(message: Messages.success),
      );
      ownPost.value = ownPost.where((e) => e.id != id).toList();
    });
    getOwnPost(null, []);
    Get.back();
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
    final token = await storage.read(StorageKeys.token.name);

    if (token != null) {
      refreshUser();
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

  // @override
  // void onReady() async {
  //   final token = await storage.read(StorageKeys.token.name);
  //   if ((user == null || user?.accessToken == null) && token != null) {
  //     await setupApp();
  //   }
  //   super.onReady();
  // }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
