import 'package:get/get.dart';
import 'package:landlord/model/user.dart';
import 'package:landlord/provider/api_prodiver.dart';
import 'package:landlord/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<bool> registerEmail(String email, String password) async {
    return await apiRepository.register(email, password);
  }

  Future<bool> forgotPassword(String email) async {
    return await apiRepository.forgotPassword(email);
  }

  Future<bool> forgotPasswordVerify(
      String password, String code, String email) async {
    return await apiRepository.verifyForgotPassword(password, code, email);
  }

  login(String username, String password) async {
    try {
      User user = await apiRepository.login(username, password);
      await _saveTokens(user.accessToken!)
          .then((value) => Get.toNamed(Routes.main));
      return user;
    } catch (e) {
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

  Future<void> _saveTokens(String token) async {
    final prefs = Get.find<SharedPreferences>();
    await prefs.setString(StorageKeys.token.name, token);
    Get.find<SplashController>().token.value = token;
  }
}
