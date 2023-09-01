import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:landlord/model/user.dart';
import 'package:landlord/provider/api_prodiver.dart';
import 'package:landlord/provider/dio_provider.dart';
import 'package:landlord/routes.dart';

import './splash_controller.dart' show SplashController;
import '../../../shared/index.dart';

class AuthController extends GetxController {
  ApiRepository apiRepository = ApiRepository(apiProvider: DioProvider());

  final storage = GetStorage();

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
