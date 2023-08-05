import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tureeslii/controllers/main_controller.dart';
import 'package:tureeslii/model/models.dart';
import 'package:tureeslii/provider/api_prodiver.dart';

import './splash_controller.dart' show SplashController;
import '../../../shared/index.dart';

class AuthController extends GetxController {
  final ApiRepository apiRepository;
  AuthController({required this.apiRepository});
  final prefs = Get.find<SharedPreferences>();
  final city = "Улаанбаатар".obs;
  final username = "".obs;
  final password = "".obs;

  @override
  onInit() {
    super.onInit();
  }

  Future<bool> registerEmail(String email, String password) async {
    return await apiRepository.register(email, password);
  }



  Future<bool> forgotPassword(String email) async {
    return await apiRepository.forgotPassword(email);
  }

  Future<bool> forgotPasswordVerify(
      String password, String code, String email) async {
    final res = await apiRepository.verifyForgotPassword(password, code, email);

    return res;
  }

  login(String username, String password) async {
    try {
      User user = await apiRepository.login(username, password);
      _saveTokens(user.accessToken!);

      return user;
    } catch (e) {
      print(e);
      return e;
    }
  }

  Future<void> logout() async {
    final prefs = Get.find<SharedPreferences>();
    await prefs.remove(StorageKeys.token.name);

    Get.find<SplashController>().token.value = null;
  }

  @override
  void dispose() {
    super.dispose();
  }

  _saveTokens(String token) async {
    final prefs = Get.find<SharedPreferences>();
    await prefs.setString(StorageKeys.token.name, token);
    Get.find<SplashController>().token.value = token;
  }
}
