import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tureeslii/model/models.dart';
import 'package:tureeslii/provider/api_prodiver.dart';

import './splash_controller.dart' show SplashController;
import '../../../shared/index.dart';

class AuthController extends GetxController {
  ApiRepository apiRepository = ApiRepository();
  final storage = GetStorage();

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
    await storage.remove(StorageKeys.token.name);

    Get.find<SplashController>().token.value = null;
  }

  @override
  void dispose() {
    super.dispose();
  }

  _saveTokens(String token) async {
    await storage.write(StorageKeys.token.name, token);
    Get.find<SplashController>().token.value = token;
  }
}
