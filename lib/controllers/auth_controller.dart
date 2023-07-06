import 'package:dio/dio.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:landlord/provider/api_prodiver.dart';

import './splash_controller.dart' show SplashController;
import '../../../shared/index.dart';

class AuthController extends GetxController {
  final ApiRepository apiRepository;
  AuthController({required this.apiRepository});
  final prefs = Get.find<SharedPreferences>();

  @override
  onInit() {
    super.onInit();
  }

  register(BuildContext context) async {
    try {
      // _saveTokens(res);
      // Get.snackbar(
      //   'Бүртгэл амжилттай',
      //   " asdf",
      //   snackPosition: SnackPosition.TOP,
      //   backgroundColor: success,
      //   colorText: Colors.white,
      // );
    } on DioError catch (e) {}
  }

  login(BuildContext context) async {
    try {} on DioError catch (e) {}

    // forgetPassword(BuildContext context) async {
    //   AppFocus.unfocus(context);
    // }

    Future<void> logout() async {
      final prefs = Get.find<SharedPreferences>();
      await prefs.remove(StorageKeys.token.name);
      Get.find<SplashController>().token.value = null;
    }

    @override
    void dispose() {
      super.dispose();
    }

    // _saveTokens(LoginResponse res) async {
    //   final prefs = Get.find<SharedPreferences>();
    //   await prefs.setString(StorageKeys.token.name, res.token);
    //   Get.find<SplashController>().token.value = res.token;
    // }
  }
}
