import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:landlord/provider/api_provider.dart';
import 'package:landlord/routes.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'dart:developer' as dev;
import './splash_controller.dart' show SplashController;
import '../../../shared/index.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AuthController extends GetxController {
  ApiRepository apiRepository = ApiRepository();
  final fetchLoading = false.obs;
  final storage = GetStorage();
  final code = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  @override
  onInit() {
    super.onInit();
  }

  registerEmail(String email, String password, BuildContext context) async {
    try {
      fetchLoading.value = true;
      final res = await apiRepository.register(email, password);
      res.fold(
          (l) => showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.info(message: l),
              ), (r) {
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(message: Messages.success),
        );
        logout();
        Get.toNamed(Routes.auth);
      });
      fetchLoading.value = false;
    } catch (e) {
      fetchLoading.value = false;
      dev.log(e.toString());
    }
  }

  forgotPassword(BuildContext context) async {
    try {
      fetchLoading.value = true;
      final res = await apiRepository.forgotPassword(email.text);
      res.fold((l) => showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.info(message: l),
              ), (r) => showTopSnackBar(
                Overlay.of(context),
                const CustomSnackBar.success(message: "Амжилттай илгээлээ."),
              ));
      fetchLoading.value = false;
    } catch (e) {
      fetchLoading.value = false;
      dev.log(e.toString());
    }
  }

  forgotPasswordVerify(BuildContext context) async {
    try {
      final res =
          await apiRepository.verifyForgotPassword(password.text, code.text, email.text);
      res.fold((l) => showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.info(message: l),
              ), (r) => {
        showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.success(message: Messages.success),
              ),
              Get.toNamed(Routes.auth)
      });
      code.clear();
      email.clear();
      password.clear();
    } catch (e) {
      dev.log(e.toString());
    }
  }

  login(String username, String password, BuildContext context) async {
    try {
      fetchLoading.value = true;
      final res = await apiRepository.login(username, password);
      res.fold(
          (l) => showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.info(message: l),
              ), (r) {
        Overlay.of(context);
        CustomSnackBar.success(message: Messages.success);
        _saveTokens(r.accessToken ?? '')
            .then((value) => Get.toNamed(Routes.main));
      });
      fetchLoading.value = false;
    } catch (e) {
      fetchLoading.value = false;
      return e.toString();
    }
  }

  Future<void> logout() async {
    await storage.remove(StorageKeys.token.name);

    Get.find<SplashController>().token.value = null;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _saveTokens(String token) async {
    await storage.write(StorageKeys.token.name, token);
    Get.find<SplashController>().token.value = token;
  }
}
