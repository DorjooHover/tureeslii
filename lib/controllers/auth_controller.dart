import 'package:get/get.dart';
import 'package:landlord/provider/api_prodiver.dart';
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

  Future<void> register(
      String username, phone, lastname, firstname, password) async {
    try {
      bool res = await apiRepository.register(
          username, password, phone, firstname, lastname);
    } catch (e) {}
  }

  login(String username, String password) async {
    try {
      await apiRepository.login(username, password);

      // _saveTokens(user.accessToken!);

      // return user;
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

  _saveTokens(String token) async {
    final prefs = Get.find<SharedPreferences>();
    await prefs.setString(StorageKeys.token.name, token);
    Get.find<SplashController>().token.value = token;
  }
}
